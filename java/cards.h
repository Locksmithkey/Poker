#include <string>

using namespace std;

class cards {

public:
	cards();
	cards(string cardFile);
	
	void shuffle();
	void chooseHand();
	
	void fileHandling(string cardFile);
	void handCombinations();
	void handScore();
	void sortHand(vector<string>& h);
	int rankCard(string c);
	int cardSuit(string c);
	string scoring(vector<string> h);
	void printHand();
	void printHand(vector<string> h);
};
