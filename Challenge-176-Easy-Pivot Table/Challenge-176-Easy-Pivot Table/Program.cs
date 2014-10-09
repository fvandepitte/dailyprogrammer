using System;
using System.Collections.Generic;
using System.Collections.Concurrent;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

namespace Challenge_176_Easy_Pivot_Table
{
    class Program
    {
        static void Main(string[] args)
        {
            var lines = File.ReadAllLines(args[0]);
            var windmills = new ConcurrentDictionary<int, WindMill>();
            
            Parallel.ForEach(lines, (line) => 
            {
                var rawData = line.Split(' ');
                if (!windmills.ContainsKey(int.Parse(rawData[0])))
                {
                    
                }
            });
        }
    }

    enum Day
    {
        Mon = 0, Tue, Wed, Thu, Fri, Sat, Sun
    }

    class WindMill
    {
        public WindMill(int id)
        {
            this.ID = id;
            this.Records = new ConcurrentBag<Record>();
        }

        public int ID { get; set; }
        public ConcurrentBag<Record> Records { get; private set; }
    }


    class Record
    {
        public Record(Day day, int kwh)
        {
            this.Day = day;
            this.kWh = kwh;
        }

        public Day Day { get; private set; }
        public int kWh { get; set; }
    }
}
