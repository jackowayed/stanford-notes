// guaranteed to be a 2x(1..inf) board
int MaxScore(Grid<int> & b){
	int prev = max(b[0][0], b[1][0]);
	if (b.numCols() == 1) return prev;
	int curr = max(prev, max(b[0][1], b[1][1]));

	// not neceessary
	if (b.numCols() == 2) return curr;

	for (int col = 2; col < b.numCols(); col++) {
		// can't use adjacent columns at all thanks to it only being 2xn
		int next = max(curr, prev + max(b[0][col], b[1][col]));
		prev = curr;
		curr = next;
	}
	return curr;
}