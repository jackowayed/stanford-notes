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

void ListSubsets(string set){
  ListSubsets(set, " ");
}

void ListSubsets(string rest, string fixed){

}