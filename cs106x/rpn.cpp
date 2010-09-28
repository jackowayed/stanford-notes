int Eval(string expr){
  Stack<int> memory;
  for (int i=0; i<expr.size(); i++){
	if (isdigit(expr[i])){
	  // ew, this is how you go char-to-int
	  // this does <ASCII code for the digit> - <ASCII code for 0>
	  memory.push(expr[i] - '0');
	}
	else{
	  int second = memory.pop();
	  int first = memory.pop();
	  memory.push(Combine(first, expr, second));
	}
	assert(memory.size() == 1);
	return memory.pop();
  }
}

int Combine(int f, char op, int s){
  switch(op){
  case '+': return f+s;
	//etc
  }
}
