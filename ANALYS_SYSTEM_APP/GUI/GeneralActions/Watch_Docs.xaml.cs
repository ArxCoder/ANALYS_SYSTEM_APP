using CsvHelper.Configuration;
using CsvHelper;
using System;
using System.Collections.Generic;
using System.Globalization;
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
using OfficeOpenXml;
using System.Collections.ObjectModel;
using ANALYS_SYSTEM_APP.GUI.EmploeeActions;
using ANALYS_SYSTEM_APP.GUI.ReporterActions;
using ANALYS_SYSTEM_APP.GUI.User_Actions;
using System.Dynamic;

namespace ANALYS_SYSTEM_APP.GUI.GeneralActions
{


    /// <summary>
    /// Логика взаимодействия для Watch_Docs.xaml
    /// </summary>
    public partial class Watch_Docs : Window
    {
        Database database = new Database();
        User current_User;
        //Таймер для отображения текущего времени
        DispatcherTimer CurrentTimer = new DispatcherTimer();
        private readonly string pathToLoadedFiles = $@"{System.IO.Directory.GetCurrentDirectory()}\FILES\";
        public Watch_Docs(User current_User)
        {
            InitializeComponent();
            this.current_User = current_User;

            Username.Text = $"{current_User.User_Role.Name}: {current_User.Surname} {current_User.Name} {current_User.Lastname}";

            //Установка текущего времени
            CurrentDate.Text = DateTime.Now.ToShortDateString();
            CurrentTimer.Tick += CurrentTimer_Tick;
            CurrentTimer.Interval = TimeSpan.FromSeconds(1);
            CurrentTimer.Start();

            DocumentsSortByType.ItemsSource = database.Data_Source.ToList();

            //Загрузка списка документов
            Refresh_Doc_List(database.Document.ToList());
        }

        //Функция загрузки списка документов
        private void Refresh_Doc_List(List<Document> Docs)
        {
            Loaded_Docs_Files.ItemsSource = null;
            Loaded_Docs_Files.Items.Clear();
            Loaded_Docs_Files.ItemsSource = Docs;
        }

        //Получение текущего времени
        private void CurrentTimer_Tick(object sender, EventArgs e)
        {
            CurrentTime.Text = DateTime.Now.ToString("HH:mm:ss");
        }

        private void Loaded_Docs_Files_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            Document selected_Doc = Loaded_Docs_Files.SelectedItem as Document;

            string pathToFileFromDB = $"{pathToLoadedFiles}{selected_Doc.Name}";

            if (!File.Exists(pathToFileFromDB))
            {
                MessageBox.Show("Файл не найден, обратитесь к администратору для решения проблемы", 
                    "Ошибка чтения файла", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            if (pathToFileFromDB.EndsWith(".csv"))
                LoadCsvToDataGrid(pathToFileFromDB);
            else if (pathToFileFromDB.EndsWith(".xlsx"))
                LoadExcelToDataGrid(pathToFileFromDB);
        }

        private void LoadExcelToDataGrid(string filePath)
        {
            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;

            using (var package = new ExcelPackage(new FileInfo(filePath)))
            {
                var worksheet = package.Workbook.Worksheets[0]; // Берем первый лист
                int colCount = worksheet.Dimension.End.Column;
                int rowCount = worksheet.Dimension.End.Row;

                var data = new List<ExpandoObject>();

                // Получаем заголовки
                var headers = new List<string>();
                for (int col = 1; col <= colCount; col++)
                {
                    headers.Add(worksheet.Cells[1, col].Text);
                }

                // Читаем строки и конвертируем в ExpandoObject
                for (int row = 2; row <= rowCount; row++) // Начинаем со 2-й строки, так как 1-я — заголовки
                {
                    var expando = new ExpandoObject() as IDictionary<string, object>;
                    for (int col = 1; col <= colCount; col++)
                    {
                        expando[headers[col - 1]] = worksheet.Cells[row, col].Text;
                    }
                    data.Add((ExpandoObject)expando);
                }

                // Очищаем старые колонки
                Selected_Doc_Data.Columns.Clear();
                foreach (var key in headers)
                {
                    Selected_Doc_Data.Columns.Add(new DataGridTextColumn
                    {
                        Header = key,
                        Binding = new Binding($"[{key}]")
                    });
                }

                // Преобразуем в Dictionary<string, object> для привязки
                var list = data.Select(expando =>
                    ((IDictionary<string, object>)expando)
                    .ToDictionary(kvp => kvp.Key, kvp => kvp.Value?.ToString() ?? "")
                ).ToList();

                // Привязываем к DataGrid
                Selected_Doc_Data.ItemsSource = null;
                Selected_Doc_Data.ItemsSource = list;
                Selected_Doc_Data.Items.Refresh();
            }
        }


        private void LoadCsvToDataGrid(string filePath)
        {
            using (var reader = new StreamReader(filePath))
            using (var csv = new CsvReader(reader, new CsvConfiguration(CultureInfo.InvariantCulture) { Delimiter = ";" }))
            {
                var records = csv.GetRecords<dynamic>().ToList();
                var data = new List<ExpandoObject>();

                foreach (var record in records)
                {
                    var expando = new ExpandoObject() as IDictionary<string, object>;
                    foreach (var kvp in (IDictionary<string, object>)record)
                    {
                        expando[kvp.Key] = kvp.Value ?? "";
                    }
                    data.Add((ExpandoObject)expando);
                }

                if (data.Count > 0)
                {
                    Selected_Doc_Data.Columns.Clear(); // Очищаем старые колонки
                    foreach (var key in ((IDictionary<string, object>)data[0]).Keys)
                    {
                        Selected_Doc_Data.Columns.Add(new DataGridTextColumn
                        {
                            Header = key,
                            Binding = new Binding($"[{key}]") // Привязка к ключу
                        });
                    }
                }

                var list = data.Select(expando =>
                ((IDictionary<string, object>)expando)
                .ToDictionary(kvp => kvp.Key, kvp => kvp.Value?.ToString() ?? "")
                ).ToList();

                Selected_Doc_Data.ItemsSource = null;
                Selected_Doc_Data.ItemsSource = list;
                Selected_Doc_Data.Items.Refresh();
            }
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

        private void DocumentsSortByName_KeyDown(object sender, KeyEventArgs e)
        {
            try
            {
                //Строка, содержащая часть или полное наименование типа документа
                string contains = DocumentsSortByName.Text.ToString();
                //Источник данных загрузки документа
                Data_Source selectedType = new Data_Source();

                if (DocumentsSortByType.SelectedItem == null)
                {   
                    //Если не выбран источник загрузки документа, то загрузка документов только по имени
                    Refresh_Doc_List(database.Document.Where(doc => doc.Document_Type.Name.Contains(contains)).ToList());
                }
                else
                {
                    //Список неоходимых для загрузки документов
                    List<Document> neededDocs = new List<Document>();
                    //Выбранный тип источника данных
                    List<Load_History> load_History = database.Load_History.Where(lh => lh.Data_Source_ID == selectedType.ID).ToList();

                    foreach (Load_History story in load_History)
                    {
                        neededDocs.Add(database.Document.Where(doc => doc.ID == story.Document_ID).FirstOrDefault());
                    }

                    //Загрузка сортированного списка документов
                    selectedType = DocumentsSortByType.SelectedItem as Data_Source;
                    Refresh_Doc_List(database.Document.Where(doc => doc.Document_Type.Name.Contains(contains) && doc.Type_ID == selectedType.ID).ToList());
                }
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void DocumentsSortByType_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            try 
            {
                Data_Source selectedDocType = DocumentsSortByType.SelectedItem as Data_Source;
                string contains = DocumentsSortByName.Text.ToString();

                List<Document> neededDocs = new List<Document>();
                List<Load_History> load_History = database.Load_History.Where(lh => lh.Data_Source_ID == selectedDocType.ID).ToList();

                foreach (Load_History story in load_History)
                {
                    neededDocs.Add(database.Document.Where(doc => doc.ID == story.Document_ID).FirstOrDefault());
                }

                if (String.Equals(contains, String.Empty))
                {
                    Refresh_Doc_List(neededDocs);
                }
                else
                {
                    Refresh_Doc_List(neededDocs.Where(doc => doc.Document_Type.Name.Contains(contains)).ToList());
                }
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void DropFilters_Click(object sender, RoutedEventArgs e)
        {
            Refresh_Doc_List(database.Document.ToList());
        }
    }
}
