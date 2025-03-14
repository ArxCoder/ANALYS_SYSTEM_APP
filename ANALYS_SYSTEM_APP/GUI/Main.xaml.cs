using System;
using System.Collections.Generic;
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
        public MainWindow()
        {
            InitializeComponent();
            string path = $"{System.IO.Directory.GetCurrentDirectory()}/Assets/Main_gif.gif";
            var gif = new BitmapImage(new Uri(path));
            ImageBehavior.SetAnimatedSource(GifImage, gif);
        }

        private void Enter_BTN_MouseEnter(object sender, MouseEventArgs e)
        {
            TextBlock tb = sender as TextBlock;
            tb.TextDecorations = TextDecorations.Underline; // Добавляем подчеркивание
        }

        private void Enter_BTN_MouseLeave(object sender, MouseEventArgs e)
        {
            TextBlock tb = sender as TextBlock;
            tb.TextDecorations = null; // Убираем подчеркивание
        }

        private void Enter_BTN_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            Auth_Modal_Form.Visibility = Visibility.Visible;
        }

        private void Reg_BTN_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            MessageBox.Show("Для регистрации обратитесь лично к администратору или заполните форму ниже.", "Регистрация",
                MessageBoxButton.OKCancel, MessageBoxImage.Information);
        }

        private void Close_Modal_Auth_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            Auth_Modal_Form.Visibility = Visibility.Hidden;
        }
    }
}
