using System;
using System.Collections.Generic;
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
    }
}
