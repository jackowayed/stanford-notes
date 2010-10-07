

struct location { double x;
	double y;
};
int LocationCompare(location one, location two) { if (one.x == two.x) return OperatorCmp(one.y, two.y); return OperatorCmp(one.x, two.x);
}
static const double kThresholdDist = 1.5; bool IsInRange(location one, location two) {
	double deltax = one.x - two.x; double deltay = one.y - two.y; return sqrt(deltax * deltax + deltay * deltay) < kThresholdDist;
} 
location OptimalInitLocation(Set<location>& landmines);

// check every possible placement
// which has highest score?

// not a good recursive problem!! 
// too much issue with making sure different branches don't explode the same mine, etc

int turn = 0;
int score = 0;
// while mines can still be exploded
// expolde all mines in range. save that
// update score
// second++;

location OptimalInitLocation(Set<location>& landmines){
	int bestScore = -1;
	location bestMine;
	foreach(location mine in landmines){
		int currScore = GetScore(mine, landmines);
		if (currScore > bestScore) {
			bestMine = mine;
			bestScore = currScore;
		}
	}
	return bestScore;
}


int GetScore(location mine, Set<location>& landmines){
	int score = 0;
	int time = 0;
	Set<location> unexploded = landmines;
	unexploded.remove(mine);
	Set<location> exploding;
	exploding.add(mine);

	while (!exploding.isEmpty()){
		Set<location> currExploding = exploding;
		exploding.clear();
		time++;
		foreach (location m in currExploding){
			score += 100 * second * second;
			// use isInRange to find everything around it and put in set
		}
	}
}