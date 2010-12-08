Vector::Vector() {
  loglength = 0;
  alloclength = 4;
  elems = new double[alloclength];
}

Vector::~Vector(){
  delete[] elems;
}

double Vector::getAt(int index){
  return elems[index];
}

void Vector::add(double elem){
  if (loglength == alloclength) grow();

  elems[loglength++] = elem;
}

void Vector::grow(){
  alloclength *= 2;
  double *newElemes = new double[alloclength];
  for (int i = 0; i < loglength; i++) newElems[i] = elems[i];
  delete[] elems;
  elems = newElems;
}
