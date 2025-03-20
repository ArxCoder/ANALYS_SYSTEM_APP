using System;
using System.Collections.Generic;
using System.Data.Entity.Migrations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using System.Windows.Threading;
using ANALYS_SYSTEM_APP.GUI;

namespace ANALYS_SYSTEM_APP.GUI.ModeratorActions
{
    /// <summary>
    /// Логика взаимодействия для RegistrationRequestList.xaml
    /// </summary>
    public partial class RegistrationRequestList : Window
    {
        Database database = new Database();
        //Таймер для отображения текущего времени
        DispatcherTimer CurrentTimer = new DispatcherTimer();
        //Таймер для обновления списков заявок на регистрацию
        DispatcherTimer RefreshLists = new DispatcherTimer();

        Registration_Request selected_request;
        User current_User;
        public RegistrationRequestList(User currentUser)
        {
            InitializeComponent();
            this.current_User = currentUser;
            Username.Text = $"{current_User.User_Role.Name}: {current_User.Surname} {current_User.Name} {current_User.Lastname}";

            //Установка текущего времени
            CurrentDate.Text = DateTime.Now.ToShortDateString();
            CurrentTimer.Tick += CurrentTimer_Tick;
            CurrentTimer.Interval = TimeSpan.FromSeconds(1);
            CurrentTimer.Start();

            RefreshRequestLists();
            //Установка информации о списках заявок на регистрацию
            RefreshLists.Interval = TimeSpan.FromMinutes(5);
            RefreshLists.Tick += RefreshLists_Tick;
            RefreshLists.Start();
        }

        private void RefreshLists_Tick(object sender, EventArgs e)
        {
            RefreshRequestLists();
        }

        private void RefreshRequestLists()
        {
            Old_Registration_Request_List.ItemsSource = null;
            Old_Registration_Request_List.Items.Clear();
            Old_Registration_Request_List.ItemsSource = database.Registration_Request.Where(rr => rr.Request_Status_ID != 1).ToList();

            New_Registration_Request_List.ItemsSource = null;
            New_Registration_Request_List.Items.Clear();
            New_Registration_Request_List.ItemsSource = database.Registration_Request.Where(rr => rr.Request_Status_ID == 1).ToList();
        }

        //Получение текущего времени
        private void CurrentTimer_Tick(object sender, EventArgs e)
        {
            CurrentTime.Text = DateTime.Now.ToString("HH:mm:ss");
        }

        private void Return_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            ModeratorWindow moderatorWindow = new ModeratorWindow(this.current_User);
            moderatorWindow.Show();
            this.Close();
        }

        private void Accept_Request_Click(object sender, RoutedEventArgs e)
        {
            Registration_Request selected_request = New_Registration_Request_List.SelectedItem as Registration_Request;

            MessageBoxResult messageBoxResult = MessageBox.Show("Вы уверены, что хотите одобрить эту заявку?",
                "Одобрение заявки",
                MessageBoxButton.YesNo,
                MessageBoxImage.Question);

            if (messageBoxResult == MessageBoxResult.No)
                return;

            selected_request.Request_Status_ID = 3;
            database.Registration_Request.AddOrUpdate(selected_request);

            User new_user = new User()
            {
                Name = selected_request.Name,
                Surname = selected_request.Surname,
                Lastname = selected_request.Lastname,
                Login = selected_request.Login,
                Password = selected_request.Password,
                Creation_date = selected_request.Creation_Date,
                Role_ID = 1,
                User_Status_ID = 1,
                Birth = selected_request.Birth
            };
            database.User.Add(new_user);

            database.SaveChanges();

            RefreshRequestLists();
        }

        private void Decline_Request_Click(object sender, RoutedEventArgs e)
        {
            selected_request = New_Registration_Request_List.SelectedItem as Registration_Request;

            MessageBoxResult messageBoxResult = MessageBox.Show("Вы уверены, что хотите отклонить эту заявку?",
                "Отклонение заявки",
                MessageBoxButton.YesNo,
                MessageBoxImage.Question);

            if (messageBoxResult == MessageBoxResult.No)
                return;

            MessageBox.Show("Для отклонения данной заявки необходимо указать причину",
                "Отклонение заявки",
                MessageBoxButton.OK,
                MessageBoxImage.Information);

            Decline_Modal.Visibility = Visibility.Visible;
        }

        private void Decline_Request_Act(Registration_Request request)
        {
            request.Request_Status_ID = 4;
            database.Registration_Request.AddOrUpdate(request);

            Request_Decline request_Decline = new Request_Decline()
            {
                Decline_Reason = Decline_Reason.Text,
                Registration_Request_ID = request.ID,
                User_ID = current_User.ID
            };
            database.Request_Decline.Add(request_Decline);

            database.SaveChanges();
        }

        private void Decline_Request_BTN_Click(object sender, RoutedEventArgs e)
        {
            if (String.Equals(Decline_Reason.Text, String.Empty))
            {
                MessageBox.Show("Для отклонния заявки укажите причину",
                    "Отклонение заявки", MessageBoxButton.OK, MessageBoxImage.Exclamation);
                return;
            }

            Decline_Request_Act(selected_request);
            RefreshRequestLists();
            MessageBox.Show("Заявка отклонена", "Отклонение заявки",
                MessageBoxButton.OK, MessageBoxImage.Information);
            Decline_Modal.Visibility = Visibility.Hidden;
        }

        private void Decline_Request_Cancel_Click(object sender, RoutedEventArgs e)
        {
            selected_request = null;
            Decline_Reason.Text = String.Empty;
            Decline_Modal.Visibility = Visibility.Hidden;
        }
    }
}
