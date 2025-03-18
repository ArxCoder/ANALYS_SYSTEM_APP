﻿using System;
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

namespace ANALYS_SYSTEM_APP.GUI
{
    /// <summary>
    /// Логика взаимодействия для ModeratorWindow.xaml
    /// </summary>
    public partial class ModeratorWindow : Window
    {
        Database database = new Database();
        DispatcherTimer RequestInfo_Timer = new DispatcherTimer();
        User current_User;
        public ModeratorWindow(User current_User)
        {
            InitializeComponent();
            this.current_User = current_User;
            Username.Text = $"{current_User.User_Role.Name}: {current_User.Surname} {current_User.Name} {current_User.Lastname}";
            SetRequestInfo();
            RequestInfo_Timer.Tick += RequestInfo_Timer_Tick;
            RequestInfo_Timer.Interval = TimeSpan.FromSeconds(15);
            RequestInfo_Timer.Start();
        }

        private void RequestInfo_Timer_Tick(object sender, EventArgs e)
        {
            SetRequestInfo();
        }

        private void Logout_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            MessageBoxResult MB_dialog_Result = MessageBox.Show("Вы уверены, что хотите выйти?", "Уведомление о выходе",
                MessageBoxButton.YesNo, MessageBoxImage.Question);

            if (MB_dialog_Result == MessageBoxResult.Yes)
            {
                MainWindow mainWindow = new MainWindow();
                mainWindow.Show();
                this.Close();
            }
        }

        private void SetRequestInfo()
        {
            if (database.Registration_Request.Where(rr => rr.Request_Status_ID == 1 || rr.Request_Status_ID == 2).Count() > 0)
            {
                Registration_Request_Count.Text = $"У вас есть необработанные заявки на регистрацию: " +
                    $"{database.Registration_Request.Where(rr => rr.Request_Status_ID == 1 || rr.Request_Status_ID == 2).Count()}";
            }
            else
            {
                Registration_Request_Count.Text = "У вас пока нет необработанных заявок на регистрацию";
            }
        }
    }
}
