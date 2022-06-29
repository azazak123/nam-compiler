#include <cstddef>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>

using namespace std;

int main(int argc, char **argv) {

  string namFilePath = string(argv[1]);

  ifstream in(namFilePath);
  ofstream outHs, outTxt;

  int i = 0, j = 0;

  string rule, decryptStr = "(\"\" --> \"\")";

  outHs.open("./lib/Main.hs");

  outHs
      << "import Lib\nmain =\n  getLine\n    >>= (putStrLn.(`loop`\n      (\n";

  std::vector<string> commands = vector<string>();

  if (in.is_open()) {
    while (getline(in, rule)) {
      commands.push_back(rule);
    }
  } else {
    cout << "File not found" << endl;
    return 0;
  }

  for (int index = commands.size() - 1; index >= 0; index--) {

    rule = commands[index];

    for (int z = 0; z < rule.length(); z++) {
      if (rule[z] == ' ') {
        rule.erase(z, 1);
      }
    }

    for (; i < rule.length(); i++) {
      if (rule[i] == '=') {
        decryptStr.replace(decryptStr.find("--"), 2, "==");

        break;
      } else if (rule[i] == '-') {
        break;
      }

      decryptStr.insert(decryptStr.find("\" -"), 1, rule[i]);
    }

    int second = i + 2;

    for (i += 2; i < rule.length(); i++, j++) {
      string searchStr = "> \"" + rule.substr(second, i - second);
      int index = decryptStr.find(searchStr) + 3 + i - second;
      decryptStr.insert(index, 1, rule[i]);
    }

    outHs << "        " << decryptStr << endl;

    i = 0;
    decryptStr = ". (\"\" --> \"\")";
  }

  outHs << "      )\n    ))";

  in.close();
  outHs.close();

  system("cd ./lib && ghc  -o ../nam -threaded -rtsopts "
         "-with-rtsopts=-N --make "
         "Main.hs");
}
