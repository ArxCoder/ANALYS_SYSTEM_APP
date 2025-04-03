using ANALYS_SYSTEM_APP.GUI;
using ANALYS_SYSTEM_APP.GUI.EmploeeActions;
using ANALYS_SYSTEM_APP.GUI.ReporterActions;
using ANALYS_SYSTEM_APP.GUI.User_Actions;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Runtime.InteropServices;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Interop;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using WpfAnimatedGif;

namespace ANALYS_SYSTEM_APP
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        Database database = new Database();
        SHA256 sha256 = SHA256.Create();
        //Ссылки для перехода на сайт
        private readonly string Vk_Url = "https://vk.com/armoryx";
        private readonly string TG_Url = "https://t.me/Armoryx";
        private readonly string Git_Url = "https://github.com/ArxCoder/ANALYS_SYSTEM_APP";
        public MainWindow()
        {
            InitializeComponent();
            //Путь к GIF-изображению при старте формы
            string path = $"{System.IO.Directory.GetCurrentDirectory()}/Assets/Main_gif.gif";

            //Загрузка и установка GIF-изображения
            BitmapImage gif = new BitmapImage(new Uri(path));
            ImageBehavior.SetAnimatedSource(GifImage, gif);
        }

        private void Enter_BTN_MouseEnter(object sender, MouseEventArgs e)
        {
            //Добавление подчеркивания при наведении на надпись
            TextBlock tb = sender as TextBlock;
            tb.TextDecorations = TextDecorations.Underline;
        }

        private void Enter_BTN_MouseLeave(object sender, MouseEventArgs e)
        {
            //Удаление подчеркивания с надписи
            TextBlock tb = sender as TextBlock;
            tb.TextDecorations = null; 
        }

        private void Enter_BTN_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            //Появление модального окна при нажатии на надпись войти
            if (Reg_Modal_Form.Visibility == Visibility.Visible)
            {
                MessageBox.Show("Для авторизации закройте форму регистрации", "Уведомление", MessageBoxButton.OK,
                    MessageBoxImage.Exclamation);
                return;
            }
            Auth_Modal_Form.Visibility = Visibility.Visible;
        }

        private void Reg_BTN_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            //Нажатие на кнопку зарегистрироваться
            MessageBoxResult MB_Dialog_Result = MessageBox.Show("Для регистрации обратитесь лично к администратору или заполните форму ниже.", "Регистрация",
                MessageBoxButton.OKCancel, MessageBoxImage.Information);

            if (MB_Dialog_Result == MessageBoxResult.Cancel)
                return;

            if (Auth_Modal_Form.Visibility == Visibility.Visible)
            {
                MessageBox.Show("Для регистрации закройте форму авторизации", "Уведомление", MessageBoxButton.OK, 
                    MessageBoxImage.Exclamation);
                return;
            }

            Reg_Modal_Form.Visibility = Visibility.Visible;
        }

        private void Close_Modal_Auth_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            //Закрытие модального окна авторизации при нажатии на крестик
            Auth_Modal_Form.Visibility = Visibility.Hidden;

            //Очистка полей формы
            Auth_Login_Input.Text = string.Empty;
            Auth_Password_Input.Text = string.Empty;
        }

        private void Git_IMG_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            //Переход по ссылке на GIT
            Process.Start(new ProcessStartInfo(Git_Url) { UseShellExecute = true });
        }

        private void TG_IMG_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            //Переход по ссылке на Telegram
            Process.Start(new ProcessStartInfo(TG_Url) { UseShellExecute = true });
        }

        private void Vk_IMG_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            //Переход по ссылке на VK
            Process.Start(new ProcessStartInfo(Vk_Url) { UseShellExecute = true });
        }

        private void Close_Modal_Reg_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            //Закрытие модального окна заявки на регистрацию
            Reg_Modal_Form.Visibility = Visibility.Hidden;

            //Очистка полей формы
            Reg_Name_Input.Text = string.Empty;
            Reg_Surname_Input.Text = string.Empty;
            Reg_Lastname_Input.Text = string.Empty;
            Reg_Login_Input.Text = string.Empty;
            Reg_Password_Input.Text = string.Empty;
            Reg_Bith_Select.Text = string.Empty;
        }

        //Обработка нажатия кнопки Регистрация
        private void Reg_Click(object sender, RoutedEventArgs e)
        {
            //Валидация на пустые поля
            if (
                String.Equals(Reg_Name_Input.Text, String.Empty) ||
                String.Equals(Reg_Surname_Input.Text, String.Empty) ||
                String.Equals(Reg_Lastname_Input.Text, String.Empty) ||
                String.Equals(Reg_Login_Input.Text, String.Empty) ||
                String.Equals(Reg_Password_Input.Text, String.Empty) ||
                String.Equals(Reg_Bith_Select.Text, String.Empty)
                )
            {
                MessageBox.Show("Для создания заявки на регистрацию заполните все поля.", "Ошибка регистрации", MessageBoxButton.OK,
                    MessageBoxImage.Exclamation);
                return;
            }

            //Регулярное выражение на проверку пароля
            string pattern = @"^(?=.*\d)(?=.*[A-Z])(?=.*[:,\-+_]).{10,}$";
            if (!Regex.IsMatch(Reg_Password_Input.Text, pattern))
            {
                MessageBox.Show("Пароль должен соответствовать следующим требованиям:" +
                    "\nМинимум 1 цифра, 1 заглвная буква, 1 спец символ: : , - + _" +
                    "\nМинимальная длина пароля 10 символов", "Ошибка регистрации",
                    MessageBoxButton.OK, MessageBoxImage.Exclamation);
                return;
            }

            string Name = Reg_Name_Input.Text;
            string Surname = Reg_Surname_Input.Text;
            string Lastname = Reg_Lastname_Input.Text;
            string Login = Reg_Login_Input.Text;
            string Password = Reg_Password_Input.Text;
            DateTime Date = (DateTime)Reg_Bith_Select.SelectedDate;
            double time = DateTime.Today.Subtract(Date).TotalDays;

            if ((time / 365) < 18 || (time / 365) > 70)
            {
                MessageBox.Show("Возраст должен входить в рамки от 18 до 70 лет",
                    "Ошибка регистрации", MessageBoxButton.OK,
                    MessageBoxImage.Exclamation);
                return;
            }

            try
            {
                //Проверка на существование пользователя с таким же логином
                User selected_User = database.User.Where(u => u.Login == Login).FirstOrDefault();
                Registration_Request selected_request = database.Registration_Request.Where(sr => sr.Login == Login 
                && sr.Request_Status_ID != 4).FirstOrDefault();
                if (selected_User != null || selected_request != null)
                {
                    MessageBox.Show("Пользователь с таким логином уже существует.", "Ошибка регистрации", MessageBoxButton.OK,
                        MessageBoxImage.Exclamation);
                    return;
                }

                //Хеширование пароля
                byte[] PasswordBytes = Encoding.UTF8.GetBytes(Password);
                byte[] PasswordHash = sha256.ComputeHash(PasswordBytes);

                string HeshedPassword = Convert.ToBase64String(PasswordHash);

                //Создание заявки на регистрацию
                Registration_Request registration_Request = new Registration_Request()
                {
                    Name = Name,
                    Surname = Surname,
                    Lastname = Lastname,
                    Login = Login,
                    Password = HeshedPassword,
                    Creation_Date = DateTime.Now,
                    Request_Status_ID = 1,
                    Role_ID = 1,
                    Birth = Date
                };

                database.Registration_Request.Add(registration_Request);
                database.SaveChanges();
                MessageBox.Show("Заявка на регистрацию успешно создана, ожидайте вынсения решения по ней", "Успешная регистрация", 
                    MessageBoxButton.OK, MessageBoxImage.Information);
            }
            catch (Exception err)
            {
                MessageBox.Show(err.Message);
            }
        }

        //Обработка нажатия кнопки Войти
        private void Enter_Click(object sender, RoutedEventArgs e)
        {
            //Валидация на пустые поля
            if(
                String.Equals(Auth_Login_Input.Text, String.Empty) ||
                String.Equals(Auth_Password_Input.Text, String.Empty)
                )
            {
                MessageBox.Show(
                    "Для авторизации заполните все поля", 
                    "Ошибка авторизации", 
                    MessageBoxButton.OK,
                    MessageBoxImage.Exclamation);

                return;
            }

            string Login = Auth_Login_Input.Text;
            string Password = Auth_Password_Input.Text;

            try
            {
                //Валидация на существование пользователя
                User seleced_User = database.User.Where(u => u.Login == Login).FirstOrDefault();
                if (seleced_User == null)
                {
                    MessageBox.Show(
                        "Пользователя с таким логином не существует.",
                        "Ошибка авторизации",
                        MessageBoxButton.OK,
                        MessageBoxImage.Exclamation);

                    return;
                }

                //Хеш текущего пароля
                byte[] CurrentPassBytes = Encoding.UTF8.GetBytes(Password);
                byte[] CurrentPassHash = sha256.ComputeHash(CurrentPassBytes);

                string Current_Pass = Convert.ToBase64String(CurrentPassHash);

                Login_History login_History = new Login_History()
                {
                    Date = DateTime.Now,
                    User_ID = seleced_User.ID,
                    Login_Status_ID = 1
                };

                //Сравнения хеша пароля пользователя и текущего
                if (!String.Equals(Current_Pass, seleced_User.Password))
                {
                    MessageBox.Show(
                        "Неверный логин или пароль.",
                        "Ошибка авторизации",
                        MessageBoxButton.OK,
                        MessageBoxImage.Exclamation);

                    login_History.Login_Status_ID = 2;

                    database.Login_History.Add(login_History);
                    database.SaveChanges();

                    return;
                }

                if (seleced_User.User_Status_ID == 3)
                {
                    MessageBox.Show("Ваша учетная запись заблокирована администратором, обратитесь к нему для решения проблемы.",
                        "Ошибка авторизации", MessageBoxButton.OK, MessageBoxImage.Error);

                    login_History.Login_Status_ID = 3;

                    database.Login_History.Add(login_History);
                    database.SaveChanges();

                    return;
                }                

                database.Login_History.Add(login_History);
                database.SaveChanges();

                //Определение рабочей формы по роли пользователя
                switch (seleced_User.Role_ID)
                {
                    case 1:
                        //Форма пользователя
                        User_Window userWindow = new User_Window(seleced_User);
                        userWindow.Show();
                        this.Close();
                        break;
                    case 2:
                        //Форма сотрудника
                        EmployeWindow employeWindow = new EmployeWindow(seleced_User);
                        employeWindow.Show();
                        this.Close();
                        break;
                    case 3:
                        //Форма администратора
                        ModeratorWindow moderatorWindow = new ModeratorWindow(seleced_User);
                        moderatorWindow.Show();
                        this.Close();
                        break;
                    case 4:
                        //Форма репортера
                        ReporterWindow reporterWindow = new ReporterWindow(seleced_User);
                        reporterWindow.Show();
                        this.Close();
                        break;
                }
            }
            catch(Exception err)
            {
                MessageBox.Show(err.Message);
            }
        }
    }
}
