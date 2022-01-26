#include <iostream>
#include <fstream>
#include <string>

using namespace std;

int main()
{
	ifstream in("crypt.txt");
	ofstream outHs, outTxt;
	
    int i = 0, j = 0; 

    string rule, decryptStr = "(\"\" --> \"\")";
    
    outHs.open("../Haskell/app/Main.hs");
    outTxt.open("decrypt.txt");
    
    
	outHs << "import Lib\nmain =\n  getLine\n    >>= (putStrLn.(\'loop\'\n      (\n";
	outTxt << "import Lib\nmain =\n  getLine\n    >>= (putStrLn.(\'loop\'\n      (\n";

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
    			outHs << "        " << decryptStr.replace(decryptStr.find("-"), 2, "==") << endl;
    			outTxt << "        " << decryptStr << endl;
			}
    		else 
    		{
    			outHs << "        " << decryptStr << endl;
    			outTxt << "        " << decryptStr << endl;
			}
    		
    		i = 0;
    		decryptStr = ". (\"\" --> \"\")";
		}

		outHs << "      )\n    ))";
		outTxt << "      )\n    ))";
	}
}
