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
