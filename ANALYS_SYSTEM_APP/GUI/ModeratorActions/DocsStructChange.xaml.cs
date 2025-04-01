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
    /// Логика взаимодействия для DocsStructChange.xaml
    /// </summary>
    public partial class DocsStructChange : Window
    {
        Database database = new Database();
        User current_User;
        //Таймер для отображения текущего времени
        DispatcherTimer CurrentTimer = new DispatcherTimer();
        public DocsStructChange(User current_User)
        {
            InitializeComponent();
            this.current_User = current_User;

            Username.Text = $"{current_User.User_Role.Name}: {current_User.Surname} {current_User.Name} {current_User.Lastname}";

            //Установка текущего времени
            CurrentDate.Text = DateTime.Now.ToShortDateString();
            CurrentTimer.Tick += CurrentTimer_Tick;
            CurrentTimer.Interval = TimeSpan.FromSeconds(1);
            CurrentTimer.Start();

            RefreshFileStructList(database.Document_Struct.ToList());
        }

        private void RefreshFileStructList(List<Document_Struct> document_Structs)
        {
            FileStructList.ItemsSource = null;
            FileStructList.Items.Clear();
            FileStructList.ItemsSource = document_Structs;
        }

        //Получение текущего времени
        private void CurrentTimer_Tick(object sender, EventArgs e)
        {
            CurrentTime.Text = DateTime.Now.ToString("HH:mm:ss");
        }

        private void Return_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            ModeratorWindow moderatorWindow = new ModeratorWindow(current_User);
            moderatorWindow.Show();
            this.Close();
        }
    }
}
