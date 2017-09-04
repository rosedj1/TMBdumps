#include<iostream>
#include<fstream>
#include<string>
using namespace std;

// Reads HV values from file and stores it in HV_array
void getValues()	
{
	// User chooses HVdatafile
	string HVdatafile;

	cout << "Take HV data from which file?" << endl;
	cin >> HVdatafile;

	// Reading data from HVdatafile
	ifstream textfile(HVdatafile);	
	
	// Exit program if HVdatafile doesn't exist	
	if ( !textfile.is_open() )
	{
		cout << "Could not open file." << endl;
		// Signal error, exit program
		exit(1);
		//return -1;
	}

	int HVarray[100];	// Make array with number of elements equal to number of entries in HVdatafile?
	int x=0;

	while (textfile>>HVarray[x++])
	{
	}
	textfile.close();

	// Display values in array.
	for (int j=0;HVarray[j]!=0;j++) {cout << HVarray[j] << endl;}	
}

int main()
{
	char answer;
	cout << "Do you want to make an array of HV data? (y or n): ";
	
	// Make another array.
	do 
	{ 
	cin >> answer;
		if (answer == 'y') { getValues(); }
		else
		{ cout << "Program exited." << endl;
		exit(1);
		}
	cout << endl << "Make another HV array? (y or n): " << endl;
	}
	while (answer == 'y');
return 0;
}
