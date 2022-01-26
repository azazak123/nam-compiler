#include <iostream>
#include <fstream>
#include <string>

using namespace std;

int main()
{
	ifstream in("crypt.txt");
	ofstream out;
	
    int i = 0, j = 0; 

    string rule, decryptStr = "(\"\" --> \"\")";
    
    out.open("decrypt.txt");
    
    if (in.is_open())
    {	
    	while (getline(in, rule))
    	{
    		for (int z = 0; z < sizeof(rule); z++)
    		{
    			if (rule[z] == ' ')
    			{
    				rule.erase(z, 1);
				}
			}
			
    		for (i; i < sizeof(rule); i++)
    		{	
    			if (rule[i] == '-' || rule[i] == '=')
    			{
    				break;
				}
				
				decryptStr.insert(decryptStr.find('\"') + 1, 1, rule[i]);
			}
	
    		for (i += 2, j; i < rule.length(); i++, j++)
    		{
        		decryptStr.insert(decryptStr.find('>') + 3, 1, rule[i]);
    		}
    		
    		if (rule.find("=>"))
    		{
    			out << decryptStr.replace(decryptStr.find("-"), 2, "==") << endl;
			}
    		else 
    		{
    			out << decryptStr << endl;
			}
    		
    		i = 0;
    		decryptStr = ". (\"\" --> \"\")";
		}
	}
}
