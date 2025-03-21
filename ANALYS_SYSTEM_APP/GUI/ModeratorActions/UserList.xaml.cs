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

namespace ANALYS_SYSTEM_APP.GUI.ModeratorActions
{
    /// <summary>
    /// Логика взаимодействия для UserList.xaml
    /// </summary>
    public partial class UserList : Window
    {
        Database database = new Database();
        //Таймер для отображения текущего времени
        DispatcherTimer CurrentTimer = new DispatcherTimer();
        User current_User;
        public UserList(User current_User)
        {
            InitializeComponent();
            this.current_User = current_User;
            //Установка информации о пользователе
            Username.Text = $"{current_User.User_Role.Name}: {current_User.Surname} {current_User.Name} {current_User.Lastname}";

            //Установка текущего времени
            CurrentDate.Text = DateTime.Now.ToShortDateString();
            CurrentTimer.Tick += CurrentTimer_Tick;
            CurrentTimer.Interval = TimeSpan.FromSeconds(1);
            CurrentTimer.Start();

            Users_List.ItemsSource = database.User.ToList();
            User_Role.ItemsSource = database.User_Role.ToList();
            User_Status.ItemsSource = database.User_Status.ToList();
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

        private void Users_List_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            if (Users_List.SelectedItem == null)
            {
                MessageBox.Show("Для редактирования информации о пользователе выберите его из списка",
                    "Редактирование пользователя", MessageBoxButton.OK, MessageBoxImage.Information);
                return;
            }

            User selected_User = Users_List.SelectedItem as User;
            if (selected_User == null)
            {
                return;
            }

            User_Name.Text = selected_User.Name;
            User_Surname.Text = selected_User.Surname;
            User_Lastname.Text = selected_User.Lastname;
            User_Status.SelectedItem = selected_User.User_Status;
            User_Role.SelectedItem = selected_User.User_Role;

            User_Login_History.ItemsSource = null;
            User_Login_History.Items.Clear();
            User_Login_History.ItemsSource = database.Login_History.Where(lh => lh.User_ID == selected_User.ID).ToList().OrderByDescending(lh => lh.Date);
        }

        private void Save_User_Changes_Click(object sender, RoutedEventArgs e)
        {
            if (Users_List.SelectedItem == null)
            {
                MessageBox.Show("Для редактирования информации о пользователе выберите его из списка",
                    "Редактирование пользователя", MessageBoxButton.OK, MessageBoxImage.Information);
                return;
            }

            User selected_User = Users_List.SelectedItem as User;
            if (selected_User == null)
            {
                return;
            }

            if (current_User.Role_ID == 3 && User_Role.SelectedItem == database.User_Role.Where(ur => ur.ID == 3).FirstOrDefault())
            {
                MessageBox.Show("У вас недостаточно прав, для присвоения выбранному пользователю роли 'Администратор'",
                    "Редактирование пользователя", MessageBoxButton.OK, MessageBoxImage.Exclamation);
                return;
            }

            selected_User.Name = User_Name.Text;
            selected_User.Surname = User_Surname.Text;
            selected_User.Lastname = User_Lastname.Text;
            selected_User.User_Role = User_Role.SelectedItem as User_Role;
            selected_User.User_Status = User_Status.SelectedItem as User_Status;

            database.User.AddOrUpdate(selected_User);
            database.SaveChanges();

            MessageBox.Show("Изменения сохранены");

            Users_List.ItemsSource = null;
            Users_List.Items.Clear();
            Users_List.ItemsSource = database.User.ToList();
        }
    }
}
