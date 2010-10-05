void LookAndSay(){
  int curr = 1;
  while (true){
	cout << curr << endl;
	curr = Next(curr);
  }
}

int Next(int curr){
	string str = IntegerToString(curr);
	string result;
	int pos = 0;
	while (pos < str.size()) {
		char ch = str[pos];
		int count = 1;
		while ((pos + count < str.size()) && str[pos + count] == ch) count++;
		result += (count + '0');
		// equivalent:
		// result += IntegerToString(count);
		result += ch;
		pos += count;
	}
	return StringToInteger(result);
}

