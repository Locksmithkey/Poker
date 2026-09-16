#include "cards.cpp"
#include <string>
#include <iostream>

using namespace std;

int main(int argc, char *argv[]) {

	cards poker;

	cout << "\n*** P O K E R  H A N D  A N A L Y E R ***" << endl;

	if(argc > 1) {

		cout << "\n*** USING TEST DECK ***" << endl;
		cout << "\n*** File: " << argv[1] << endl;
	
		cards poker(argv[1]);
	} 
	else {

		cout << "\n*** USING RANDOMIZED DECK OF CARDS ****" << endl << endl;
	
		cout << "\n*** Shuffled 52 card deck: " << endl;
		poker.shuffle();

		cout << "\n*** Here is the hand" << endl; 
		poker.chooseHand();
		
		cout << endl;

	}

	cout << "\n*** Hand Combinations..." << endl;
        poker.handCombinations();
	
	cout << "--- HIGH HAND ORDER ---" << endl;
	poker.handScore();
		

	return 0;
}
