int main() {
  // This makes board a local variable `board` associated with an 8x8 board.
  //It's NOT a pointer to the grid.
  Grid<bool> board(8,8);

  ClearBoard(board);
  PlaceQueens(board, 5);
  UpdateBoard(board);
}

void ClearBoard(Grid<bool> & board){
  for (int row = 0; row < board.numRows(); row++){
	for (int col = 0; col < board.numCols(); col++){
	  board[row][col] = false;
	}
  }
}

void PlaceQueens(Grid<bool> & b, int numToPlace){
  Randomize();
  // if you comment out Randomize(), you'll get the same random numbers in the same order each time. Can help with debugging.
  // should really call it in main()
  int numplaced = 0;
  while (numPlaced < NumToPlace){
	int r = RandomInteger(0, b.numRows()-1);
	int c = RandomInteger(0,b.numCols()-1);
	if (!b[r][c]){
	  b[r][c] = true;
	  numPlaced++;
	}
  }
}

bool isSafe(Grid<bool> & b, int row, int col){
  // bad way
  return (IsSouthwestSafe(b,row,col) && IsSouthSafe(b,row,col) &&...);
}
