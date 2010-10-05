template <typename ValueType>

class Map {
public: 
  Map(int sizeHint = 10001);
  // sizeHint is a guess of the size to help it be more efficient
  ~Map();

  bool isEmpty();
  int size();

  // all generally O(1)
  void put(string key, ValueType value);
  ValueType get(string key);
  bool containsKey(string key);

private:
  // don't need to know
}


// read in file with \n-separated words
// make m a map that maps word => number of times word appears
void BuildMap(Map<int> & m, ifstream & infile){
  while (true){
	string word;
	getline(infile, word);
	if (infile.fail()) return;
	int freq = 0;
	if (m.containsKey(word))
	  freq = m.get(word);
	m.put(word, freq+1);
  }
}

// alternate syntax for m.get(word):
// m[word]
// will insert an undefined value if it's not there

// and m.put(foo, bar) can be m[foo] = bar;

// you can even do m[foo]++;


// print to file so that each line is "key:val"
void SerializeMap(Map<int> & n, ofstream & outfile){
  // not in stock C++
  foreach (string key in m){
	outfile << key << ":" << m[key] << endl;
  }
}
