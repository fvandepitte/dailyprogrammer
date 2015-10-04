#include <iostream>
#include <string>
#include <vector>
#include <map> 
#include <sstream>
#include <iterator>


using namespace std;


inline vector<string> Split(string str)
{
	istringstream buf(str);
	istream_iterator<string> beg(buf), end;

	vector<string> tokens(beg, end);
	return tokens;
}


class Student
{
	public:
		Student(string name, string lastName, vector<int> points);
		~Student();
		string GetResult();
		string CalculateGrade();
		int CalculateAvarage();

	private:
		vector<int> _points;
		map<string, int> _pointMapping;
		string _name, _lastName;
};

string Student::GetResult()
{
	char buffer[255];
	sprintf_s(buffer, "%-10s %-10s  %-10s% %-10s", _name, _lastName, CalculateGrade());


	return buffer;
}

int Student::CalculateAvarage()
{
	int total = 0;
	for each (int result in _points)
	{
		total += result;
	}
	return total / _points.size();
}

string Student::CalculateGrade()
{
	int avarage = CalculateAvarage();

	for (std::map<string, int>::iterator it = _pointMapping.begin(); it != _pointMapping.end(); ++it)
	{
		if (avarage > it->second)
		{
			return it->first;
		}
	}
	return "F";
}

Student::Student(string name, string lastName, vector<int> points)
{
	_pointMapping["A"] = 93;
	_pointMapping["A-"] = 90;
	_pointMapping["B+"] = 87;
	_pointMapping["B"] = 83;
	_pointMapping["B-"] = 80;
	_pointMapping["C+"] = 77;
	_pointMapping["C"] = 73;
	_pointMapping["C-"] = 70;
	_pointMapping["D+"] = 67;
	_pointMapping["D"] = 63;
	_pointMapping["D-"] = 60;
	_pointMapping["F"] = 0;


	_name = name;
	_lastName = lastName;
	_points = points;
}

Student::~Student()
{
}

int main()
{
	string results[] =
	{
		"Valerie Vetter 79   81  78  83  80",
		"Richie  Rich    88  90  87  91  86"
	};

	vector<Student> students = vector<Student>();
	for each (string row in results)
	{
		vector<string> val = Split(row);
		string name = val[0];
		string lastname = val[1];
		val.erase(val.begin(), val.begin() + 1);
		vector<int> points;
		for each (string point in val)
		{
			points.push_back(atoi(point.c_str()));
		}
		students.push_back(Student(name, lastname, points));
	}

	return 0;
}

