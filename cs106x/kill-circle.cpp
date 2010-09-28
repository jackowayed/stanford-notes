void IdentifySurvivors(int numPeople, int numToSpare, int & lastKilled, int & nextToLastKilled){
  Queue<int> circle;
  for (int n = 1; n <= numPeople; n++)
	circle.enqueue(n);

  while (!circle.isEmpty){
	for (int k = 0; k<numToSpare; k++)
	  circle.enqueue(circle.dequeue());
	nextToLastKilled = lastKilled;
	lastKilled = circle.dequeue();
}
