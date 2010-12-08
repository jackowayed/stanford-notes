void Grid::resize(int nRows, int nCols){
  if (elems != NULL){
	for (int r = 0; r < this->nRows; r++){
	  delete[] elems[r];
	}
	delete[] elems;
  }
  this->nRows = nRows;
  this->nCols = nCols;
  elems = new double *[nRows];
  for (int r = 0; r < nRows; r++){
	elems[r] = new double[nCols];
  }
}
