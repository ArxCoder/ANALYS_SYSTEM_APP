using Microsoft.Win32;
using Newtonsoft.Json;
using OfficeOpenXml;
using OfficeOpenXml.Style.XmlAccess;
using System;
using System.Collections.Generic;
using System.IO;
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
    /// Логика взаимодействия для Load_Doc_Wnd.xaml
    /// </summary>
    public partial class Load_Doc_Wnd : Window
    {
        User current_User;
        Database database = new Database();
        //Таймер для отображения текущего времени
        DispatcherTimer CurrentTimer = new DispatcherTimer();
        private readonly string pathToLoadedFiles = $@"{System.IO.Directory.GetCurrentDirectory()}\FILES\";
        private string pathToSelectedFile;
        public Load_Doc_Wnd(User current_User)
        {
            InitializeComponent();
            this.current_User = current_User;

            Username.Text = $"{current_User.User_Role.Name}: {current_User.Surname} {current_User.Name} {current_User.Lastname}";

            //Установка текущего времени
            CurrentDate.Text = DateTime.Now.ToShortDateString();
            CurrentTimer.Tick += CurrentTimer_Tick;
            CurrentTimer.Interval = TimeSpan.FromSeconds(1);
            CurrentTimer.Start();

            New_Doc_Src.ItemsSource = database.Data_Source.ToList();
            New_Doc_Type.ItemsSource = database.Document_Type.ToList();

            Refresh_Doc_List();
        }

        //Получение текущего времени
        private void CurrentTimer_Tick(object sender, EventArgs e)
        {
            CurrentTime.Text = DateTime.Now.ToString("HH:mm:ss");
        }

        private void Return_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            EmployeWindow employeWindow = new EmployeWindow(this.current_User);
            employeWindow.Show();
            this.Close();
        }

        private void Refresh_Doc_List()
        {
            Loaded_Docs_Files.ItemsSource = null;
            Loaded_Docs_Files.Items.Clear();
            Loaded_Docs_Files.ItemsSource = database.Document.ToList();
        }

        private void Load_New_Doc_Click(object sender, RoutedEventArgs e)
        {
            if (New_Doc_Src.SelectedItem is null ||
                New_Doc_Type.SelectedItem is null)
            {
                MessageBox.Show("Для выбора файла заполните все поля", "Загрузка документа",
                    MessageBoxButton.OK, MessageBoxImage.Exclamation);
                return;
            }

            try
            {
                OpenFileDialog openFileDialog = new OpenFileDialog();
                openFileDialog.Multiselect = false;
                openFileDialog.Filter = "Excel files (*.xlsx)|*.xlsx";

                if (openFileDialog.ShowDialog() == false)
                {
                    MessageBox.Show("Для загрузки выберите Excel таблицу",
                        "Загрузка документа", MessageBoxButton.OK, MessageBoxImage.Exclamation);
                    return;
                }

                pathToSelectedFile = openFileDialog.FileName;

                Document_Type selectedType = New_Doc_Type.SelectedItem as Document_Type;
                string AttributesList = database.Document_Struct.Where(ds => ds.Type_ID == selectedType.ID).Select(dt => dt.Attributes_List).FirstOrDefault();
                List<string> neededHeaders = JsonConvert.DeserializeObject<List<string>>(AttributesList);

                if (ValidateExcelHeaders(neededHeaders, pathToSelectedFile))
                {
                    if (File.Exists($"{pathToLoadedFiles}{openFileDialog.SafeFileName}"))
                    {
                        MessageBox.Show("Файл с таким именем уже существует, переименуйте файл", "Ошибка загрузки",
                            MessageBoxButton.OK, MessageBoxImage.Exclamation);
                        return;
                    }

                    File.Copy(pathToSelectedFile, $"{pathToLoadedFiles}{openFileDialog.SafeFileName}");

                    Document newDocument = new Document()
                    {
                        Date = DateTime.Now,
                        Name = openFileDialog.SafeFileName,
                        Status_ID = 1,
                        Type_ID = selectedType.ID
                    };

                    database.Document.Add(newDocument);
                    database.SaveChanges();

                    Data_Source data_Source = New_Doc_Src.SelectedItem as Data_Source;

                    Load_History load_History = new Load_History()
                    {
                        Source_File_Name = openFileDialog.FileName,
                        Date = DateTime.Now,
                        User_ID = current_User.ID,
                        Document_ID = newDocument.ID,
                        Data_Source_ID = data_Source.ID
                    };

                    database.Load_History.Add(load_History);
                    database.SaveChanges();
                    Refresh_Doc_List();
                    MessageBox.Show("Файл успешно загружен", "Загрузка файла",
                        MessageBoxButton.OK, MessageBoxImage.Information);
                }
                else
                {
                    MessageBox.Show("Выбранный файл не соответствует структуре", "Ошибка загрузки",
                        MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private bool ValidateExcelHeaders(List<string> expectedHeaders, string filePath)
        {
            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;

            using (var package = new ExcelPackage(new System.IO.FileInfo(filePath)))
            {
                var worksheet = package.Workbook.Worksheets[0];
                int columnCount = worksheet.Dimension.End.Column;

                List<string> actualheaders = new List<string>();

                for (int col = 1; col <= columnCount; col++)
                {
                    actualheaders.Add(worksheet.Cells[1, col].Text.Trim());
                }

                return expectedHeaders.All(actualheaders.Contains) && actualheaders.All(expectedHeaders.Contains);
            }
        }
    }
}
