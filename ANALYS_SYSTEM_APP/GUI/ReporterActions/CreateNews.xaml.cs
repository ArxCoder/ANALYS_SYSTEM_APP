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

namespace ANALYS_SYSTEM_APP.GUI.ReporterActions
{
    /// <summary>
    /// Логика взаимодействия для CreateNews.xaml
    /// </summary>
    public partial class CreateNews : Window
    {
        Database database = new Database();
        //Таймер для отображения текущего времени
        DispatcherTimer CurrentTimer = new DispatcherTimer();
        User current_User;
        public CreateNews(User current_User)
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

            News_List.ItemsSource = database.Organisation_News.ToList();
        }

        //Получение текущего времени
        private void CurrentTimer_Tick(object sender, EventArgs e)
        {
            CurrentTime.Text = DateTime.Now.ToString("HH:mm:ss");
        }

        private void Return_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            ReporterWindow reporterWindow = new ReporterWindow(this.current_User);
            reporterWindow.Show();
            this.Close();
        }

        private void News_List_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            Organisation_News selected_news = News_List.SelectedItem as Organisation_News;

            News_Name.Text = selected_news.Name;
            News_Description.Text = selected_news.Description;
        }
    }
}
