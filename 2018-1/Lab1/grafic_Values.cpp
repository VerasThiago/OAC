#include <bits/stdc++.h>
using namespace std;
#define N 50e6

int main(){
	double instruc[9] = {150,185,220,535,710,1095,2145,3195,3545};
	double n[9] = {3,4,5,14,19,30,60,90,100};
	for(int i = 0; i < 9; i++)
		cout << n[i] << " = " << instruc[i]/N << endl;
}
