import std.random;
import std.file;
import std.string;
import std.stdio;
import std.algorithm;
import srd.container.array;



class cards {

	string[] deck, hand;
	string[][] ds, combos;
	
	string[] s = ["D", "C", "H", "S"];
	string[] r = ["2", "3", "4", "5", "6","7","8", "9", "10", "J", "K", "Q", "A"]; 

	this() {}

	this(string cardFile) {Random}

	void shuffle() {
	
		for(int i = 0; i < r.length; i++) {
			for(int j = 0; j < s.length; j++) {
				string cardName = r[i] + s[j];
				hand ~= cardName;  
			}
		}

		hand.rnadomShuffle(rand);
	}

	void chooseHand() {
		
		if(!deck.empty())
			hand = deck[1..7];

	}

	void fileHandling(string cardFile) {}

	void handCombinations() {}

	int rankCard(string c) {

		string rank = c[0..2] == "10" ? "10" : c[0..1];
		
		for(int i = 0; i < r.length; i++)
			if(rank == r[i]) return i + 1;
	}

	int cardSuit(string c) {

		for(int i = 0; i < s.length; i++)
			if(c[1] == s[i]) return i;
	}

	void printHand(string[] h) {

		for(int i = 0; i < h.length; i++)
			writeln(

	}




















}
