using ANALYS_SYSTEM_APP.GUI.EmploeeActions;
using ANALYS_SYSTEM_APP.GUI.User_Actions;
using System;
using System.Collections.Generic;
using System.Data.Entity.Migrations;
using System.Linq;
using System.Runtime.CompilerServices;
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
    /// Логика взаимодействия для ProviderChange.xaml
    /// </summary>
    public partial class ProviderChange : Window
    {
        Database database = new Database();
        User current_User;
        //Таймер для отображения текущего времени
        DispatcherTimer CurrentTimer = new DispatcherTimer();
        public ProviderChange(User current_User)
        {
            InitializeComponent();
            this.current_User = current_User;

            Username.Text = $"{current_User.User_Role.Name}: {current_User.Surname} {current_User.Name} {current_User.Lastname}";

            //Установка текущего времени
            CurrentDate.Text = DateTime.Now.ToShortDateString();
            CurrentTimer.Tick += CurrentTimer_Tick;
            CurrentTimer.Interval = TimeSpan.FromSeconds(1);
            CurrentTimer.Start();

            RefreshProviderList();

            ProviderOrganisationTypeList.ItemsSource = database.Organisation_Type.ToList();
            SelectedProviderOrganisationTypeList.ItemsSource = database.Organisation_Type.ToList();
        }

        private void RefreshProviderList()
        {
            ProvidersList.ItemsSource = null;
            ProvidersList.Items.Clear();
            ProvidersList.ItemsSource = database.Provider.ToList();
        }

        //Получение текущего времени
        private void CurrentTimer_Tick(object sender, EventArgs e)
        {
            CurrentTime.Text = DateTime.Now.ToString("HH:mm:ss");
        }

        private void Return_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            switch (current_User.Role_ID)
            {
                case 1:
                    //Форма пользователя
                    User_Window userWindow = new User_Window(current_User);
                    userWindow.Show();
                    this.Close();
                    break;
                case 2:
                    //Форма сотрудника
                    EmployeWindow employeWindow = new EmployeWindow(current_User);
                    employeWindow.Show();
                    this.Close();
                    break;
                case 3:
                    //Форма администратора
                    ModeratorWindow moderatorWindow = new ModeratorWindow(current_User);
                    moderatorWindow.Show();
                    this.Close();
                    break;
            }
        }

        private void ProvidersList_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            Provider selectedProvider = ProvidersList.SelectedItem as Provider;

            if (selectedProvider is null)
            {
                MessageBox.Show("Информация о выбранном поставщике отсутствует, для уточенения обратитесь к администратору", "Ошибка выбора поставщика",
                    MessageBoxButton.OK,MessageBoxImage.Error);
                return;
            }

            SelectedProviderName.Text = selectedProvider.Name;
            SelectedProviderOrganisationTypeList.SelectedItem = selectedProvider.Organisation_Type;
            SelectedProviderOwner.Text = selectedProvider.Owner;
            SelectedProviderLocation.Text = selectedProvider.Location;
        }

        private void SaveChanges_Click(object sender, RoutedEventArgs e)
        {
            if (ProvidersList.SelectedItem is null)
            {
                MessageBox.Show("Для редактирования информации о поставщике, выберите его из списка", "Ошибка редактирования поставщика",
                    MessageBoxButton.OK, MessageBoxImage.Exclamation);
                return;
            }

            if (String.Equals(SelectedProviderName.Text, String.Empty) ||
                SelectedProviderOrganisationTypeList.SelectedItem is null ||
                String.Equals(SelectedProviderOwner.Text, String.Empty) ||
                String.Equals(SelectedProviderLocation.Text, String.Empty))
            {
                MessageBox.Show("Для редактирования информации о поставщике все поля должны быть заполнены", "Ошибка редактирования поставщика",
                     MessageBoxButton.OK, MessageBoxImage.Exclamation);
                return;
            }

            Provider selectedProvider = ProvidersList.SelectedItem as Provider;
            Organisation_Type selectedType = SelectedProviderOrganisationTypeList.SelectedItem as Organisation_Type;

            selectedProvider.Name = SelectedProviderName.Text;
            selectedProvider.Organisation_Type_ID = selectedType.ID;
            selectedProvider.Owner = SelectedProviderOwner.Text;
            selectedProvider.Location = SelectedProviderLocation.Text;

            Provider_Change_Story newChange = new Provider_Change_Story()
            {
                User_ID = current_User.ID,
                Provider_ID = selectedProvider.ID,
                Date = DateTime.Now
            };

            database.Provider.AddOrUpdate(selectedProvider);
            database.Provider_Change_Story.Add(newChange);

            database.SaveChanges();

            SelectedProviderName.Text = String.Empty;
            SelectedProviderOrganisationTypeList.SelectedItem = null;
            SelectedProviderOwner.Text = String.Empty;
            SelectedProviderLocation.Text = String.Empty;

            RefreshProviderList();

            MessageBox.Show("Изменения зафиксированы", "Успех",
                MessageBoxButton.OK, MessageBoxImage.Information);
        }

        private void AddProvider_Click(object sender, RoutedEventArgs e)
        {
            if (String.Equals(ProviderName.Text, String.Empty) ||
                ProviderOrganisationTypeList.SelectedItem is null ||
                String.Equals(ProviderOwner.Text, String.Empty) ||
                String.Equals(ProviderLocation.Text, String.Empty))
            {
                MessageBox.Show("Для добаления поставщика все поля должны быть заполнены", "Ошибка создания поставщика",
                     MessageBoxButton.OK, MessageBoxImage.Exclamation);
                return;
            }

            Organisation_Type selectedType = ProviderOrganisationTypeList.SelectedItem as Organisation_Type; 
            Provider newProvider = new Provider()
            {
                Name = ProviderName.Text,
                Organisation_Type_ID = selectedType.ID,
                Owner = ProviderOwner.Text,
                Location = ProviderLocation.Text,
                Creation_Date = DateTime.Now
            };

            database.Provider.Add(newProvider);

            database.SaveChanges();

            ProviderName.Text = String.Empty;
            ProviderOrganisationTypeList.SelectedItem = null;
            ProviderOwner.Text = String.Empty;
            ProviderLocation.Text = String.Empty;

            RefreshProviderList();

            MessageBox.Show("Новый поставщик добавлен", "Успех",
                MessageBoxButton.OK, MessageBoxImage.Information);
        }
    }
}
