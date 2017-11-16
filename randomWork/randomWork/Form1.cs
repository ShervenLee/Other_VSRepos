using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace randomWork
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            //Properties.Resources.资源文件名
            string s = Properties.Resources.index;
            //Uri uri = new Uri(s);
            //webBrowser1.Navigate(uri);
            Console.Write("hello111");
        }
        private void webBrowser1_DocumentCompleted(object sender, WebBrowserDocumentCompletedEventArgs e)
        {
            Console.Write("hello");
        }
    }
}
