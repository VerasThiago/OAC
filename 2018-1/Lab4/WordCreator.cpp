#include <bits/stdc++.h>
using namespace std;
#define ll long long


void intro(){ 
        printf("\n");
        printf("#####################################\n");
        printf("#                                   #\n");
        printf("#        OAC - Control_MULT         #\n");
        printf("#                                   #\n");
        printf("#####################################\n");
        printf("#                                   #\n");
        printf("#     Aluno: Thiago Veras Machado   #\n");
        printf("#                                   #\n");
        printf("#####################################\n");
        printf("\n");
}


int main(){

    intro();

    printf("State name: ");

    string istr;

    cin >> istr;

    unordered_map<string,string> mp;
    mp["oPCcondWrite "] = "0";
    mp["oPCwrite"] = "0";
    mp["oIorD"] = "0";
    mp["oMemWrite"] = "0";
    mp["oMemRead"] = "0";
    mp["oIRWrite"] = "0";
    mp["oOriPC"] = "0";
    mp["oALUop"] = "0";
    mp["oOriAALU"] = "0";
    mp["oOriBALU"] = "0";
    mp["oRegWrite"] = "0";
    mp["oMem2Reg"] = "0";

    for(auto x: mp){
        cout << x.first << " : ";
        string op;
        cin >> op;
        mp[x.first] = op;
    }

    printf("\n---------------Final result---------------\n");

    cout << "State : " << istr << endl;
    
    int cont = 1;
    string word = "";
    
    fstream saida("out.txt", ios::out);
    
    saida << "<td class=\"column100 column " << cont << "\" data-column=\"column" << cont << "\"><center>" << istr << "</center></td>" << endl;
    
    cont++;
    
    for(auto x: mp){
        saida << "<td class=\"column100 column " << cont << "\" data-column=\"column" << cont << "\"><center>" << x.second << "</center></td>" << endl;
        word += x.second;
        cont++;
    }
    
    saida.close();
    
    cout << "Word : " << word << endl; 

}