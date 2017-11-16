using System;
using System.Windows.Forms;

namespace WindowsFormsApp2
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            // webBrowser1.Navigate(Application.StartupPath + @"\Resources\index.html");
            webBrowser1.Navigate(Properties.Resources.index + "html");


            for (int i = 0; i < 100; i++)
            {
                Console.WriteLine("------------------------------" + Environment.CurrentDirectory);
            }

        }
    }
}
