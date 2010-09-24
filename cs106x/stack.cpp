// 9/24 CS 106X

// print the stream but reversing order of the lines
void printInReverse(ifstream & infile){
  Stack<string> stack;
  while (true){
	string line;
	getline(infile, line);
	if (infile.fail()) break;
	stack.push(line);
  }
  while (!stack.isEmpty()){
	cout << stack.pop << endl;
  }
}
