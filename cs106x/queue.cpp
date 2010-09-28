class Queue {
public:

  Queue();
  ~Queue();

  bool isEmpty();
  int size();

  void enqueue(T elem);
  T dequeue();

private:
  // blissfully unaware :)
}
