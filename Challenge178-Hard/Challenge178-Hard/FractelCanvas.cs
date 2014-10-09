using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Collections.Concurrent;
using System.Text.RegularExpressions;
using System.Windows.Media;
using System.Drawing;
using System.Threading;

namespace Challenge178_Hard
{
    public class FractelCanvas : Canvas
    {
        class Pixel
        {
            public string CellName { get; set; }
            public int X { get; set; }
            public int Y { get; set; }
        }

        private ConcurrentBag<Pixel> _pixels;
        private Thread _calculationThread;

        public string FractalRegex {
            get { return (string)GetValue(RegexProperty); }
            set { SetValue(RegexProperty, value); }
        }

        // Using a DependencyProperty as the backing store for Regex.  This enables animation, styling, binding, etc...
        public static readonly DependencyProperty RegexProperty = DependencyProperty.Register("FractalRegex", typeof(string), typeof(FractelCanvas), new PropertyMetadata(""));

        public FractelCanvas() : base() {
            _pixels = new ConcurrentBag<Pixel>();
            _calculationThread = new Thread(new ParameterizedThreadStart(CalculateFractal));
            _calculationThread.Start(new Size(this.ActualWidth, this.ActualHeight));
            this.SizeChanged += FractelCanvas_SizeChanged;
        }

        void FractelCanvas_SizeChanged(object sender, SizeChangedEventArgs e) {
            if (_calculationThread.IsAlive)
            {
                _calculationThread.Abort();
            }

            _calculationThread = new Thread(new ParameterizedThreadStart(CalculateFractal));
            _calculationThread.Start(e.NewSize);
        }

        private void CalculateFractal(object objSize) {
            Size size = (Size)objSize;
            _pixels = new ConcurrentBag<Pixel>();
            GetPixel((int)(size.Height > size.Width ? size.Width : size.Height));

            this.Dispatcher.Invoke(this.InvalidateVisual);
        }

        protected override void OnRender(System.Windows.Media.DrawingContext dc) {
            
            Regex regex = new Regex(FractalRegex);
            Brush brush = new SolidColorBrush(Colors.Black);
            Pen pen = new Pen(brush, 0.5);

            foreach (Pixel pixel in _pixels.Where(p => !regex.IsMatch(p.CellName)))
            {
                dc.DrawRectangle(brush, pen, new Rect(pixel.X, pixel.Y, 1d, 1d));
            }
            
            base.OnRender(dc);
        }

        private void GetPixel(int size, int X = 0, int Y = 0, string prevSegment = "") {
            if (size == 0)
            {
                return;
            }
            
            if (size % 2 == 1)
            {
                size -= 1;
            }
            if (size / 2 == 1)
            {
                _pixels.Add(new Pixel { CellName = string.Format("{0}{1}", 1, prevSegment), X = X + 1, Y = Y });
                _pixels.Add(new Pixel { CellName = string.Format("{0}{1}", 2, prevSegment), X = X, Y = Y });
                _pixels.Add(new Pixel { CellName = string.Format("{0}{1}", 3, prevSegment), X = X, Y = Y + 1 });
                _pixels.Add(new Pixel { CellName = string.Format("{0}{1}", 4, prevSegment), X = X + 1, Y = Y + 1 });

            }
            else
            {
                int nextWidth = size / 2;
                GetPixel(nextWidth, X + nextWidth, Y, string.Format("{0}{1}", 1, prevSegment));
                GetPixel(nextWidth, X, Y, string.Format("{0}{1}", 2, prevSegment));
                GetPixel(nextWidth, X, Y + nextWidth, string.Format("{0}{1}", 3, prevSegment));
                GetPixel(nextWidth, X + nextWidth, Y + nextWidth, string.Format("{0}{1}", 4, prevSegment));
            }


        }

    }
}
