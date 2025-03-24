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

namespace ANALYS_SYSTEM_APP.GUI.User_Actions
{
    /// <summary>
    /// Логика взаимодействия для User_Window.xaml
    /// </summary>
    public partial class User_Window : Window
    {
        User current_User;
        public User_Window(User current_User)
        {
            InitializeComponent();
            this.current_User = current_User;
        }
    }
}
