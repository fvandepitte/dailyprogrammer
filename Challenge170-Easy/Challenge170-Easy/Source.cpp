#include <iostream>
#include <string>
#include <vector>

using namespace std;
int main()
{
	cout << "Give the number of players";

	string strNumberOfPlayers;
	getline(cin, strNumberOfPlayers);
	int const numberOfPlayers = atoi(strNumberOfPlayers.c_str());
	vector<string*>* playerWInfo = new vector<string*>();;
	for (int i = 0; i < numberOfPlayers; i++)
	{

	}
	delete playerWInfo;
}