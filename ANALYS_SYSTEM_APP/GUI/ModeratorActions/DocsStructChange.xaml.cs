using DocumentFormat.OpenXml.Office2010.Excel;
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

        //Установка параметров для редактирования структуры
        private void FileStructList_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            try
            {
                Document_Struct selectedStruct = FileStructList.SelectedItem as Document_Struct;
                Document_Type currentType = selectedStruct.Document_Type;

                ChangeDocTypeName.Text = currentType.Name;
                ChangeDocStructName.Text = selectedStruct.Name;
                ChangeDocStructDesc.Text = selectedStruct.Description;
                ChangeDocStructAttList.Text = selectedStruct.Attributes_List;
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        //Обработка редактирования структуры
        private void ChangeStruct_Click(object sender, RoutedEventArgs e)
        {
            if (FileStructList.SelectedItem is null)
            {
                MessageBox.Show("Для редактирования структуры выберите ее из списка", "Ошибка редактирования",
                    MessageBoxButton.OK, MessageBoxImage.Exclamation);
                return;
            }

            if (String.Equals(ChangeDocTypeName.Text, String.Empty) ||
                String.Equals(ChangeDocStructName.Text, String.Empty) ||
                String.Equals(ChangeDocStructDesc.Text, String.Empty) ||
                String.Equals(ChangeDocStructAttList.Text, String.Empty))
            {
                MessageBox.Show("Для редактирования структуры поля не должны быть пустыми", "Ошибка редактирования",
                    MessageBoxButton.OK, MessageBoxImage.Exclamation);
                return;
            }

            try
            {
                Document_Struct selectedStruct = FileStructList.SelectedItem as Document_Struct;
                ChangeStructFunc(selectedStruct);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        /// <summary>
        /// Функция для создания и записи в БД измененой структуры
        /// </summary>
        /// <param name="document_Struct"></param>
        private void ChangeStructFunc(Document_Struct document_Struct)
        {
            if (document_Struct == null)
            {
                MessageBox.Show("Ошибка изменения структуры: selected document struct is null", "Ошибка редактирования",
                    MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            try
            {
                Document_Type currentType = document_Struct.Document_Type;

                currentType.Name = ChangeDocTypeName.Text;
                document_Struct.Name = ChangeDocStructName.Text;
                document_Struct.Description = ChangeDocStructDesc.Text;
                document_Struct.Attributes_List = ChangeDocStructAttList.Text;

                database.Document_Type.AddOrUpdate(currentType);
                database.Document_Struct.AddOrUpdate(document_Struct);

                database.SaveChanges();

                RefreshFileStructList(database.Document_Struct.ToList());

                ChangeDocTypeName.Text = String.Empty;
                ChangeDocStructName.Text = String.Empty;
                ChangeDocStructDesc.Text = String.Empty;
                ChangeDocStructAttList.Text = String.Empty;

                MessageBox.Show("Изменения структуры зафиксированы", "Успешное редактирование",
                    MessageBoxButton.OK, MessageBoxImage.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        //Обработка добавления новой структуры
        private void AddNewStruct_Click(object sender, RoutedEventArgs e)
        {
            if (String.Equals(NewDocTypeName.Text, String.Empty) ||
                String.Equals(NewDocStructName.Text, String.Empty) ||
                String.Equals(NewDocStructDesc.Text, String.Empty) ||
                String.Equals(NewDocStructAttList.Text, String.Empty))
            {
                MessageBox.Show("Для создания новой структуры все поля должны быть заполнены", "Ошибка создания структуры",
                    MessageBoxButton.OK, MessageBoxImage.Exclamation);
                return;
            }

            try
            {
                Document_Type newDocType = new Document_Type()
                {
                    Name = NewDocTypeName.Text
                };

                database.Document_Type.Add(newDocType);
                database.SaveChanges();

                Document_Struct newStruct = new Document_Struct()
                {
                    Name = NewDocStructName.Text,
                    Description = NewDocStructDesc.Text,
                    Attributes_List = NewDocStructAttList.Text,
                    Creation_Date = DateTime.Now,
                    Type_ID = newDocType.ID
                };

                database.Document_Struct.Add(newStruct);
                database.SaveChanges();

                NewDocTypeName.Text = String.Empty;
                NewDocStructName.Text = String.Empty;
                NewDocStructDesc.Text = String.Empty;
                NewDocStructAttList.Text = String.Empty;

                RefreshFileStructList(database.Document_Struct.ToList());
                MessageBox.Show("Новая структура успешно добавлена", "Создание новой структуры",
                    MessageBoxButton.OK, MessageBoxImage.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
    }
}
