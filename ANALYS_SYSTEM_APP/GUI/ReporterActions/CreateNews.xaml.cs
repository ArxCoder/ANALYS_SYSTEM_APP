using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices.WindowsRuntime;
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

        string oldNameVal;
        string oldDescVal;
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

            News_List.ItemsSource = database.Organisation_News.ToList().OrderByDescending(on => on.Creation_Date);
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

            oldNameVal = selected_news.Name;
            oldDescVal = selected_news.Description;
        }

        private void Save_Changes_Click(object sender, RoutedEventArgs e)
        {
            if (News_List.SelectedItem is null)
            {
                MessageBox.Show("Для редактирования новости выберите ее из списка.",
                    "Обновление новостей", MessageBoxButton.OK, MessageBoxImage.Exclamation);
                return;
            }

            if (String.Equals(News_Description.Text, String.Empty) ||
                String.Equals(News_Name.Text, String.Empty))
            {
                MessageBox.Show("Для сохранения изменений заполните все поля.",
                    "Обновление новостей", MessageBoxButton.OK, MessageBoxImage.Exclamation);
                return;
            }

            string newNameVal = News_Name.Text;
            string newDescVal = News_Description.Text;

            Organisation_News selectedNews = News_List.SelectedItem as Organisation_News;

            if (!String.Equals(newNameVal, oldNameVal))
            {
                News_Change_History changeName = new News_Change_History()
                {
                    User_ID = current_User.ID,
                    News_ID = selectedNews.ID,
                    Old_Value = oldNameVal,
                    New_Value = newNameVal,
                    Date = DateTime.Now
                };

                selectedNews.Name = newNameVal;
                database.News_Change_History.Add(changeName);
                database.SaveChanges();
            }

            if (!String.Equals(newDescVal, oldDescVal))
            {
                News_Change_History changeDesc = new News_Change_History()
                {
                    User_ID = current_User.ID,
                    News_ID = selectedNews.ID,
                    Old_Value = oldDescVal,
                    New_Value = newDescVal,
                    Date = DateTime.Now
                };

                selectedNews.Description = newDescVal;
                database.News_Change_History.Add(changeDesc);
                database.SaveChanges();

                oldNameVal = String.Empty;
                oldDescVal = String.Empty;
                News_Name.Text = String.Empty;
                News_Description.Text = String.Empty;
            }

            MessageBox.Show("Информация о новости изменена.", "Обновление новостей",
                MessageBoxButton.OK, MessageBoxImage.Information);

            News_List.ItemsSource = null;
            News_List.Items.Clear();
            News_List.ItemsSource = database.Organisation_News.ToList().OrderByDescending(on => on.Creation_Date);
        }

        private void Add_News_Click(object sender, RoutedEventArgs e)
        {
            if (String.Equals(New_News_Name.Text, String.Empty) ||
                String.Equals(New_News_Description.Text, String.Empty))
            {
                MessageBox.Show("Для добавления новости все поля должны быть заполнены",
                    "Добавление новости", MessageBoxButton.OK, MessageBoxImage.Information);
                return;
            }

            Organisation_News organisation_News = new Organisation_News()
            {
                User_ID = current_User.ID,
                Creation_Date = DateTime.Now,
                Name = New_News_Name.Text,
                Description = New_News_Description.Text
            };

            database.Organisation_News.Add(organisation_News);
            database.SaveChanges();

            News_List.ItemsSource = null;
            News_List.Items.Clear();
            News_List.ItemsSource = database.Organisation_News.ToList().OrderByDescending(on => on.Creation_Date);

            MessageBox.Show("Новость успешно создана",
                "Добавление новости", MessageBoxButton.OK, MessageBoxImage.Information);

            New_News_Name.Text = String.Empty;
            New_News_Description.Text = String.Empty;
        }
    }
}
