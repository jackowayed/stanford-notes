class Set{
public:

  Set(int (cmp)(Elem, Elem) = OperatorCmp); // optional param that's a pointer to a function that will compare 2 Elems so you can change the sorting
  ~Set();

  void add(Elem elem);
  bool contains(Elem elem);

  // O(n)
  void intersect(Set<Elem> & other);
  void unionsWith(Set<Elem> & other);

private:
  // don't care
}

int RunExperiment(){
  int numRolls = 0;
  Set<int> numbersSeen;

  while (numbersSeen.size() < 6){
	numbersSeen.add(RandomInteger(1,6));
	numRolls++;
  }
  return numRolls;
}

template <typename Elem>
int OperatorCmp(Elem one, Elem two){
  if (one == two) return 0;
  if (one < two) return -1;
  return +1;
}


Set<string> friends(LengthCmp);
int LengthCmp(string one, string two){
  if (one.size() < two.size()) return -1;
  if (one.size() > two.size()) return +1;
  // length breaks ties.
  return OperatorCmp(one, two);
}
