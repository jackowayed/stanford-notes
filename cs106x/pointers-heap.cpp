class Vector {
public:
  Vector();
  ~Vector();


  void add(double value);
  double getAt(int index);
private:
  double *elems;
  int loglength;
  int alloclength;
  void grow;
}
// see vector.cpp
