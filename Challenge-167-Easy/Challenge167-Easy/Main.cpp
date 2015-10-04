#include <iostream>
#include <string>
#include <fstream>
#include <windows.h>
#include <Shellapi.h>

using namespace std;

int main()
{
	cout << "Enter your paragraph:" << endl;
	string paragraph;
	getline(cin, paragraph);

	ofstream myfile;
	myfile.open("167-easy.html");

	myfile << "<!DOCTYPE html>" << endl;
	myfile << "<html>" << endl;
	myfile << "    <head>" << endl;
	myfile << "        <title></title>" << endl;
	myfile << "    </head>" << endl;
	myfile << "    <body>" << endl;
	myfile << "        <p>" << paragraph << "</p>" << endl;
	myfile << "    </body>" << endl;
	myfile << "</html>" << endl;
	myfile.close();

	ShellExecute(NULL, "open", "167-easy.html", NULL, NULL, SW_SHOWMAXIMIZED);


	return 0;
}