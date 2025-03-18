using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
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
        }
    }
}
