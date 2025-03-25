using CsvHelper.Configuration;
using CsvHelper;
using Microsoft.Win32;
using Newtonsoft.Json;
using OfficeOpenXml;
using OfficeOpenXml.Style.XmlAccess;
using OfficeOpenXml.Utils;
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
        //Путь для сохранения всех новых документов
        private readonly string pathToLoadedFiles = $@"{System.IO.Directory.GetCurrentDirectory()}\FILES\";
        //Путь до выбранного файла
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

            //Загрузка информации в ComboBox
            New_Doc_Src.ItemsSource = database.Data_Source.ToList();
            New_Doc_Type.ItemsSource = database.Document_Type.ToList();

            //Загрузка списка документов
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

        //Функция загрузки списка документов
        private void Refresh_Doc_List()
        {
            Loaded_Docs_Files.ItemsSource = null;
            Loaded_Docs_Files.Items.Clear();
            Loaded_Docs_Files.ItemsSource = database.Document.ToList();
        }

        //Загрузка нового документа
        private void Load_New_Doc_Click(object sender, RoutedEventArgs e)
        {
            //Валидация на пустые значения полей
            if (New_Doc_Src.SelectedItem is null ||
                New_Doc_Type.SelectedItem is null)
            {
                MessageBox.Show("Для выбора файла заполните все поля", "Загрузка документа",
                    MessageBoxButton.OK, MessageBoxImage.Exclamation);
                return;
            }

            try
            {
                //Выбор файла
                OpenFileDialog openFileDialog = new OpenFileDialog();
                openFileDialog.Multiselect = false;
                openFileDialog.Filter = "Excel files (*.xlsx)|*.xlsx| CSV files (*.csv)|*.csv";

                if (openFileDialog.ShowDialog() == false)
                {
                    MessageBox.Show("Для загрузки выберите Excel таблицу или CSV документ",
                        "Загрузка документа", MessageBoxButton.OK, MessageBoxImage.Exclamation);
                    return;
                }

                pathToSelectedFile = openFileDialog.FileName;

                //Проверка на выбранный тип источника данных

                //Обработка CSV формата
                if (String.Equals(New_Doc_Src.Text, "CSV"))
                {
                    SaveFileAsCSV(openFileDialog);
                    return;
                }

                //Обработка xlsx формата
                if (!pathToSelectedFile.EndsWith(".xlsx"))
                {
                    MessageBox.Show("Выбран файл неверного формата", "Ошибка загрузки", 
                        MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }
                else if (pathToSelectedFile.EndsWith(".xlsx") && !String.Equals(New_Doc_Src.Text, "Excel"))
                {
                    MessageBox.Show("Неверно указано название источника данных", "Ошибка загрузки",
                        MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                Document_Type selectedType = New_Doc_Type.SelectedItem as Document_Type;
                //Получение списка необходимых заголовков в файле из БД
                string AttributesList = database.Document_Struct.Where(ds => ds.Type_ID == selectedType.ID).Select(dt => dt.Attributes_List).FirstOrDefault();
                List<string> neededHeaders = JsonConvert.DeserializeObject<List<string>>(AttributesList);

                //Проверка на соответствие заголовков
                if (ValidateExcelHeaders(neededHeaders, pathToSelectedFile))
                {
                    //Проверка на существование файла с таким же именем
                    if (File.Exists($"{pathToLoadedFiles}{openFileDialog.SafeFileName}"))
                    {
                        MessageBox.Show("Файл с таким именем уже существует, переименуйте файл", "Ошибка загрузки",
                            MessageBoxButton.OK, MessageBoxImage.Exclamation);
                        return;
                    }

                    //Копирование файла
                    File.Copy(pathToSelectedFile, $"{pathToLoadedFiles}{openFileDialog.SafeFileName}");

                    //Создание записей в БД

                    //Запись нового документа
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

                    //Запись в истории действий сотрудников
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

                    //Обновление списка загруженных документов
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

        /// <summary>
        /// Метод для валидации схожести необходимых заголовков
        /// </summary>
        /// <param name="expectedHeaders">Ожидаемые заголовки, которые должны быть</param>
        /// <param name="filePath">Путь до файла с данными</param>
        /// <returns>Результат валидации: true - заголовки верны, false - есть расхождение в наличии основных заголовков</returns>
        private bool ValidateExcelHeaders(List<string> expectedHeaders, string filePath)
        {
            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;

            //Чтение заголовков из excel таблицы
            using (var package = new ExcelPackage(new System.IO.FileInfo(filePath)))
            {
                var worksheet = package.Workbook.Worksheets[0];
                int columnCount = worksheet.Dimension.End.Column;

                //Инициализация списка заголовков в excel таблице
                List<string> actualheaders = new List<string>();

                //Перенос заголовков в список
                for (int col = 1; col <= columnCount; col++)
                {
                    actualheaders.Add(worksheet.Cells[1, col].Text.Trim());
                }

                //Сравнение списков с заголовками
                return expectedHeaders.All(actualheaders.Contains) && actualheaders.All(expectedHeaders.Contains);
            }
        }

        /// <summary>
        /// Функция сохранения CSV файла
        /// </summary>
        /// <param name="openFileDialog">Результат выбора файла</param>
        private void SaveFileAsCSV(OpenFileDialog openFileDialog)
        {
            //Проверка корректности выбора источника данных
            if (!pathToSelectedFile.EndsWith(".csv"))
            {
                MessageBox.Show("Выбран файл неверного формата", "Ошибка загрузки",
                    MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }
            else if (pathToSelectedFile.EndsWith(".csv") && !String.Equals(New_Doc_Src.Text, "CSV"))
            {
                MessageBox.Show("Неверно указано название источника данных", "Ошибка загрузки",
                    MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            Document_Type selectedType = New_Doc_Type.SelectedItem as Document_Type;
            //Получение списка необходимых заголовков в файле из БД
            string AttributesList = database.Document_Struct.Where(ds => ds.Type_ID == selectedType.ID).Select(dt => dt.Attributes_List).FirstOrDefault();
            List<string> neededHeaders = JsonConvert.DeserializeObject<List<string>>(AttributesList);

            //Проверка на соответствие заголовков
            if (ValidateCsvHeaders(pathToSelectedFile, neededHeaders))
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

        /// <summary>
        /// Метод автоматического определения кодировки CSV файла, для корректности его чтения
        /// </summary>
        /// <param name="filePath">Путь до необходимого файла</param>
        /// <returns>Возвращает кодировку выбранного файла</returns>
        static Encoding DetectFileEncoding(string filePath)
        {
            using (var reader = new StreamReader(filePath, true))
            {
                reader.Peek();
                return reader.CurrentEncoding;
            }
        }

        /// <summary>
        /// Метод валидации заголовков CSV файла аналогично валидации Excel таблиц
        /// </summary>
        /// <param name="filePath">Путь до файла с данными</param>
        /// <param name="expectedHeaders">Ожидаемые заголовки</param>
        /// <returns>Результат валидации true/false</returns>
        static bool ValidateCsvHeaders(string filePath, List<string> expectedHeaders)
        {
            //Получение кодировки выбранного файла
            var encoding = DetectFileEncoding(filePath);

            //Чтение CSV файла
            using (var reader = new StreamReader(filePath, encoding))
            using (var csv = new CsvReader(reader, new CsvConfiguration(CultureInfo.InvariantCulture)
            {
                Delimiter = ";",
                TrimOptions = TrimOptions.Trim, 
                IgnoreBlankLines = true 
            }))
            {
                csv.Read();
                csv.ReadHeader();

                //Получение списка заголовков
                var actualHeaders = csv.HeaderRecord?
                    .Select(h => h.Replace("\"", "").Trim())
                    .ToList() ?? new List<string>();

                //Сравнение заголовков
                return expectedHeaders.All(actualHeaders.Contains) && actualHeaders.All(expectedHeaders.Contains);
            }
        }
    }
}
