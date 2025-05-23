﻿using ANALYS_SYSTEM_APP.GUI.GeneralActions;
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

namespace ANALYS_SYSTEM_APP.GUI.EmploeeActions
{
    /// <summary>
    /// Логика взаимодействия для EmployeWindow.xaml
    /// </summary>
    public partial class EmployeWindow : Window
    {
        Database database = new Database();
        User current_User;
        //Таймер для отображения текущего времени
        DispatcherTimer CurrentTimer = new DispatcherTimer();
        //Таймер для обновления новостей
        DispatcherTimer RefreshNews = new DispatcherTimer();

        public EmployeWindow(User current_user)
        {
            InitializeComponent();
            this.current_User = current_user;

            //Установка информации о пользователе
            Username.Text = $"{current_User.User_Role.Name}: {current_User.Surname} {current_User.Name} {current_User.Lastname}";

            //Установка текущего времени
            CurrentDate.Text = DateTime.Now.ToShortDateString();
            CurrentTimer.Tick += CurrentTimer_Tick;
            CurrentTimer.Interval = TimeSpan.FromSeconds(1);
            CurrentTimer.Start();

            //Загрузка новостей
            setNews();
            RefreshNews.Tick += RefreshNews_Tick;
            RefreshNews.Interval = TimeSpan.FromMinutes(5);
            RefreshNews.Start();

            Users_Birth_List.ItemsSource = database.User.ToList();
        }

        private void RefreshNews_Tick(object sender, EventArgs e)
        {
            setNews();
        }

        private void setNews()
        {
            News_List.ItemsSource = null;
            News_List.Items.Clear();
            News_List.ItemsSource = database.Organisation_News.ToList().OrderByDescending(on => on.Creation_Date);
        }

        //Получение текущего времени
        private void CurrentTimer_Tick(object sender, EventArgs e)
        {
            CurrentTime.Text = DateTime.Now.ToString("HH:mm:ss");
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

        private void Load_Doc_Click(object sender, RoutedEventArgs e)
        {
            Load_Doc_Wnd load_Doc_Wnd = new Load_Doc_Wnd(current_User);
            load_Doc_Wnd.Show();
            this.Close();
        }

        private void Watch_Doc_Click(object sender, RoutedEventArgs e)
        {
            Watch_Docs watch_Doc = new Watch_Docs(current_User);
            watch_Doc.Show();
            this.Close();
        }

        private void Check_Graphs_Click(object sender, RoutedEventArgs e)
        {
            Watch_Graphs watch_Graphs = new Watch_Graphs(current_User);
            watch_Graphs.Show();
            this.Close();
        }
    }
}
