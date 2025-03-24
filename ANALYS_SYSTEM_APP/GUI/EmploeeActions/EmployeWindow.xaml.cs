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

namespace ANALYS_SYSTEM_APP.GUI.EmploeeActions
{
    /// <summary>
    /// Логика взаимодействия для EmployeWindow.xaml
    /// </summary>
    public partial class EmployeWindow : Window
    {
        User current_User;

        public EmployeWindow(User current_user)
        {
            InitializeComponent();
            this.current_User = current_user;
        }
    }
}
