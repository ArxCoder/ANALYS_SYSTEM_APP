using ANALYS_SYSTEM_APP.GUI.EmploeeActions;
using ANALYS_SYSTEM_APP.GUI.User_Actions;
using LiveCharts;
using LiveCharts.Wpf;
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
using System.Windows.Markup;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using System.Windows.Threading;

namespace ANALYS_SYSTEM_APP.GUI.GeneralActions
{
    /// <summary>
    /// Логика взаимодействия для Watch_Graphs.xaml
    /// </summary>
    public partial class Watch_Graphs : Window
    {
        SeriesCollection DocumentCounts { get; set; }
        List<string> UserNames { get; set; }

        Database database = new Database();
        User current_User;
        //Таймер для отображения текущего времени
        DispatcherTimer CurrentTimer = new DispatcherTimer();
        public Watch_Graphs(User current_User)
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
        }

        private void LoadHistoryGraph()
        {
            LoadHistoryGraphPanel.Children.Clear();

            CartesianChart newChart = new CartesianChart();
            newChart.Name = "UserChart";
            newChart.Width = 1200;
            newChart.Height = 700;
            newChart.FontSize = 14;
            newChart.FontWeight = FontWeights.Bold;
            //newChart.IsEnabled = false;

            List<ChartData> chartData = new List<ChartData>();
            User user = current_User;

            string userName = $"{user.Surname} {user.Name} {user.Lastname}";
            int documentCount = database.Load_History.Where(doc => doc.User_ID == user.ID).Count();

            if (documentCount > 0)
            {
                ChartData newChartData = new ChartData()
                {
                    UserName = userName,
                    DocumentCount = documentCount
                };

                chartData.Add(newChartData);
            }

            if (newChart.AxisX.Count > 0)
            {
                newChart.AxisX[0].Labels = chartData.Select(d => d.UserName).ToList();
            }
            else
            {
                // Если нет элементов, можно создать или добавить ось
                newChart.AxisX.Add(new Axis
                {
                    Labels = chartData.Select(d => d.UserName).ToList()
                });
            }

            newChart.Series.Add(new ColumnSeries
            {
                Title = "Документы",
                Values = new ChartValues<int>(chartData.Select(d => d.DocumentCount))
            });

            LoadHistoryGraphPanel.Children.Add(newChart);
            LoadHistoryGraphPanel.Visibility = Visibility.Visible;
        }

        private struct DocsChart
        {
            public string Name { get; set; }
            public int Count { get; set; }
        }

        private void LoadDocsGraph()
        {
            LoadHistoryGraphPanel.Children.Clear();

            CartesianChart newChart = new CartesianChart();
            newChart.Name = "UserChart";
            newChart.Width = 1200;
            newChart.Height = 700;
            newChart.FontSize = 14;
            newChart.FontWeight = FontWeights.Bold;
            //newChart.IsEnabled = false;

            List<DocsChart> docsData = new List<DocsChart>();
            foreach (Data_Source src in database.Data_Source)
            {
                string Name = src.Name;
                int Count = database.Load_History.Where(doc => doc.Data_Source_ID == src.ID && doc.User_ID == current_User.ID).Count();

                if (Count > 0)
                {
                    DocsChart newChartData = new DocsChart()
                    {
                        Name = Name,
                        Count = Count
                    };

                    docsData.Add(newChartData);
                }
            }

            if (newChart.AxisX.Count > 0)
            {
                newChart.AxisX[0].Labels = docsData.Select(d => d.Name).ToList();
            }
            else
            {
                // Если нет элементов, можно создать или добавить ось
                newChart.AxisX.Add(new Axis
                {
                    Labels = docsData.Select(d => d.Name).ToList()
                });
            }

            newChart.Series.Add(new ColumnSeries
            {
                Title = "Документы",
                Values = new ChartValues<int>(docsData.Select(d => d.Count))
            });

            LoadHistoryGraphPanel.Children.Add(newChart);
            LoadHistoryGraphPanel.Visibility = Visibility.Visible;
        }

        private struct ChartData {
            public string UserName {get; set;}
            public int DocumentCount { get; set; }
        }

        //Получение текущего времени
        private void CurrentTimer_Tick(object sender, EventArgs e)
        {
            CurrentTime.Text = DateTime.Now.ToString("HH:mm:ss");
        }

        private void CloseLoadHistoryGraph_Click(object sender, RoutedEventArgs e)
        {
            LoadHistoryGraphPanel.Visibility = Visibility.Hidden;
        }

        private void LoadGraph_LoadHistory_Click(object sender, RoutedEventArgs e)
        {
            if (LoadHistoryGraphPanel.Visibility == Visibility.Visible)
            {
                MessageBox.Show("График уже загружен", "Ошибка загрузки графика",
                    MessageBoxButton.OK, MessageBoxImage.Exclamation);
                return;
            }

            LoadHistoryGraph();
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

        private void LoadGraph_LoadDocType_Click(object sender, RoutedEventArgs e)
        {
            if (LoadHistoryGraphPanel.Visibility == Visibility.Visible)
            {
                MessageBox.Show("График уже загружен", "Ошибка загрузки графика",
                    MessageBoxButton.OK, MessageBoxImage.Exclamation);
                return;
            }

            LoadDocsGraph();
        }
    }
}
