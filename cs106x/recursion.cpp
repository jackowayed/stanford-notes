// more efficient fib than the standard recursive soln
// return nth fib number
int fib(int n){
  return fib(n, 0, 1);
}

// O(n) instead of O(2^n)
int fib(int n, int base0, int base1){
  if (n == 0) return base0;
  if (n == 1) return base1;
  return fib(n-1, base1, base0+base1);
}


// return base^exp
// O(n) (n == exp)
int power(int base, int exp){
  if (exp == 0) return 1;
  return x * power(base, exp-1);
}

// O(lgn)
int pow (int x, int n){
  if (n==0) return 1;
  int root = pow(x,n/2);
  int answer = root * root;
  if (n % 2 == 1) answer *= x;
  return answer;
}

// boxy fractal
// draws a square of size dim centered at (cx, cy)
void DrawCenteredSquare(double cx, double cy, double dim);

void DrawBoxyFractal(double cx, double cy, double dim, int order){
  if (order == 0){
	DrawCenteredSquare(cx, cy, dim);
  } else {
	DrawCenteredSquare(cx, cy, dim);
	// upper left
	DBF(cx - dim/2, cy - dim/2, 0.45 * dim, order - 1);
	//     -           -                          =
	//     +           -
	//     +           +
  }
}


// alternatively
void DrawBoxyFractal(double cx, double cy, double dim, int order){
  if (order >= 0){
	// draw the square and draw 4 boxy fractals of order order-1
	// when order is 0, those recursive calls will have order -1, and the if keeps them from doing anything
	// if you do 
	DrawCenteredSquare(etc);
	DBF x4;
	// then the bigger squares will be under the littler ones
	// if you do:
	DBF x4;
	DrawCenteredSquare(etc);
	// the biggest ones are on top
	// if DrawCenteredSquare is in the middle, some are on top, some are on bottom
  }
}


// coastline problem

// draws from where the last line ended
void DrawPolarLine(double length, double theta);
void DrawCoastline(double length, double theta, int order){
  if (order == 0){
	DrawPolarLine(length, theta);
  } else {
	// order n coastline is 4 n-1's
	int sign = RandomChance(0.5) ? -1 : +1;
	DrawCostline(length/3, theta, order -1);
	DrawCoastline(length * sqrt(2) / 6, theta + sign * 45, order -1);
	DrawCoastline(length * sqrt(2) / 6, theta - sign * 45, order -1);
	DrawCostline(length/3, theta, order -1);
  }
}

// permutations of a string

void Permutations(string str){
  Permutations("", str);
}

void Permutations(string fixedPrefix, string remaining){
  if (remaining.empty()){
	cout << fixedPrefix << endl;
	return; //unnecessary
  }
  for (int i = 0; i < remaining.size(); i++){
	Permutatoins(fixedPrefix + remaining[i],
				 remaining.substr(0, i)
				 + remaining.substr(i+1));
  }
}

// "subsets" or "powerset" of string
// eg for "ABC", subsets are
// "",   "B", "C", "BC" //these are also subsets of BC
// "A", "AB" "AC" "ABC" //these are A appended to the above
void Powerset(string set){
  Powerset("", set);
}

void Powerset(string sofar, string rest){
  if (rest.empty()){
	cout << sofar << endl;
	return;
  }
  Powerset(sofar + rest[0], rest.substr(1));
  Powerset(sofar, rest.substr(1));
}


// Tower of Hanoi
// just prints out instructions on how to do it

void MoveSingleDisk(char start, char dest){
  cout << start << "----->" << dest << endl;
}

// O(2^n)
void MoveTower(int n, char start, char dest, char temp){
  if (n > 0){
	// get everything but the bottom ring out of the way
	MoveTower(n-1, start, temp, dest);
	// move the bottom ring
	MoveSingleDisk(start, dest);
	// move the rest of the tower back on
	MoveTower(n-1, temp, dest, start);
  }
}

// generate all words spellable with periodic table abbrevs
void GenerateWords(Set<string> & symbols, Lexicon & english){
  GenerateWords("", symbols, english);
}

void GenerateWords(string prefix, Set<string> & symbols, Lexicon & english){
  if (!english.containsPrefix(prefix)) return;
  if (english.containsWord(prefix))  cout << prefix << endl;
  foreach (string symbol in symbols){
	GenerateWords(prefix + symbol, symbols, english);
  }
}

// check if word can be formed from periodic table elements
bool CanFormWord(string word, Set<string> & symbols){
  if (word.empty()) return true;
  for (int i = 0; i <= min(3, word.size()); i++){
	string symbol = word.substr(0, i);
	string remaining = word.subtr(i);
	if (symbols.contains(symbol) && CanFormWord(remaining, symbols)) return true;
  }
  return false;
}

// shrinkable words
// words where you take out one letter at time, with it staying a word each time
// eg stink
//    sink
//    sin
//    in
//    i
//
// single letters are always ok because Jerry says so
bool CanShrink(string word, Lexicon & lexicon){
  if (word.empty()) return true;
  if (!lexicon.containsWord(word)) return false;
  for (int i = 0; i < word.size(); i++){
	if (CanShrink(word.substr(0, i) + word.substr(i+1), lexicon)) return true;
  }
  return false;
}

// rewrite
bool Can(string word, Lexicon & lexicon, Stack<string> & path){
  if (word.empty()){
	path.push(word);
	return true;
  }
  if (!lex.containsWord(word)) return false;
  for (int i = 0; i < word.size(); i++){
	string candidate = word.substr(0, i) + word.substr(i+1);
	if (Can(candidate, lex, path)){
	  path.push(word);
	  return true;
	}
  }
  return false;
}

// n queens
bool Solve(Grid<bool> & board){
  return Solve(board, 0);
}
// see handout
