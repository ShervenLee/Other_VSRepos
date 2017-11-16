using System;
using System.Drawing;
using System.Windows.Forms;

namespace app
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            initAllLab();
        }

        private void listView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {


            initAllLab();

            Random rd = new Random();

            Color color = Color.FromArgb(234, 32, 0);

            int num = rd.Next(1, 5);//[1,4]
            //只是会出现4种情况
            switch (num)
            {
                case 1:
                    lab1.BackColor = color;
                    lab3.BackColor = color;
                    lab6.BackColor = color;
                    break;
                case 2:
                    lab1.BackColor = color;
                    lab4.BackColor = color;
                    lab5.BackColor = color;
                    break;
                case 3:
                    lab2.BackColor = color;
                    lab3.BackColor = color;
                    lab5.BackColor = color;
                    break;
                case 4:
                    lab2.BackColor = color;
                    lab4.BackColor = color;
                    lab6.BackColor = color;
                    break;
                default:
                    lab1.BackColor = color;
                    lab3.BackColor = color;
                    lab6.BackColor = color;
                    break;
            }

            /*
            if (num == 1)
                lab1.BackColor = color;
            else
                lab2.BackColor = color;
            num = rd.Next(1, 3);
            if (num == 1)
                lab3.BackColor = color;
            else
                lab4.BackColor = color;
            num = rd.Next(1, 3);
            if (num == 1)
                lab5.BackColor = color;
            else
                lab6.BackColor = color;
                */



            int buf1, buf2;
            buf1 = rd.Next(1, 5);//[1,4]
            buf2 = rd.Next(1, 5);//[1,4]

            while (buf2 == buf1)
            {
                buf2 = rd.Next(1, 5);//[1,4]
            }

            switch (buf1)
            {
                case 1:
                    lab7.BackColor = color;
                    break;
                case 2:
                    lab8.BackColor = color;
                    break;
                case 3:
                    lab9.BackColor = color;
                    break;
                case 4:
                    lab10.BackColor = color;
                    break;
                default:
                    lab7.BackColor = color;
                    break;
            }

            switch (buf2)
            {
                case 1:
                    lab7.BackColor = color;
                    break;
                case 2:
                    lab8.BackColor = color;
                    break;
                case 3:
                    lab9.BackColor = color;
                    break;
                case 4:
                    lab10.BackColor = color;
                    break;
                default:
                    lab7.BackColor = color;
                    break;
            }
        }
        private void initAllLab()
        {
            Color color = Color.FromArgb(48, 48, 48);
            lab1.BackColor = color;
            lab2.BackColor = color;
            lab3.BackColor = color;
            lab4.BackColor = color;
            lab5.BackColor = color;
            lab6.BackColor = color;
            lab7.BackColor = color;
            lab8.BackColor = color;
            lab9.BackColor = color;
            lab10.BackColor = color;
        }
    }
}
