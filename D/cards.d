module poker;

import std.random;
import std.file;
import std.string;
import std.stdio;
import std.algorithm;
import std.container.array;

class cards {

	string[] deck, hand;
	string[][] ds, combos;
	
	string[] s = ["D", "C", "H", "S"];
	string[] r = ["2", "3", "4", "5", "6","7","8", "9", "10", "J", "Q", "K", "A"]; 

	Random rand;

	this() {rand = Random(unpredictableSeed);}

	this(string cardFile) {}

	void  shuffle() {
	
		foreach(rank ; r) {
			foreach(suit ; s) {
				deck ~= rank ~ suit;  
			}
		}

		deck.randomShuffle(rand);
	}

	void chooseHand() {
		
		if(!deck.empty)
			hand = deck[0..7];

		printHand(hand);
	}

	void fileHandling(string cardFile) {}

	void handCombinations() {

		int n = cast(int)(hand.length);


		for(int i = 0; i < n; i++) {
			for(int j = i + 1; j < n; j++) {

				string[] handCombo;
				string[] d;

				for(int k = 0; k < n; k++) {
					if(k != i && k != j)
						handCombo ~= hand[k];
				}

				d ~= hand[i];
				d ~= hand[j];
				ds ~= d;
				combos ~= handCombo;

				printHands(handCombo);
				printHands(d);
				writeln();
			}

		}
	
	}

	void handScore() {

		for(int i = 0; i < combos.length; i++) {
			sortHand(combos[i]);
			sortHand(ds[i]);
			printHands(combos[i]);
			printHands(ds[i]);

			writefln(" - %s", scoring(combos[i]));
		}
	
		writeln();
	}

	string scoring(string[] h) {
	
		int pairs = 0;
		
		bool flush = true;
		bool straight = true;
		bool tok = false; 
		bool fok = false; 
		bool high = false;
		
		int[15] scores = 0;
		int[] val;
		 
		foreach(string cards ; h) {

			int cr = rankCard(cards);
			scores[cr]++;
			val ~= cr;
		}

		for(int i = 0; i < h.length; i++) {

			if(h[i][$-1] != h[0][$-1]) {
				flush = false; break;
			} 
		}

		val.sort!((a,b) => a < b);

		for(int i = 0; i < val.length - 1; i++) {
			if(val[i + 1] != val[i] + 1) {
				straight = false; break;
			}
		}

		for(int i = 2; i <= scores.length - 1; i++) {
			if(scores[i] == 2) pairs++;
			else if(scores[i] == 3) tok = true;
			else if(scores[i] == 4) fok = true;
		}

		if(val[0] == 10) high = true;

		if(high && straight && flush) return "Royal Straight Flush";
		if(straight && flush) return "Straight Flush";
		if(fok) return "Four of a Kind";
		if(tok && pairs == 1) return "Full House";
		if(flush) return "Flush";
		if(straight) return "Straight";
		if(tok) return "Three of a Kind";
		if(pairs == 2) return "Two Pair";
		if(pairs == 1) return "Pair";

		return "High Card";
	}

	void sortHand(ref string[] h) {
		
		h.sort!((a, b) => rankCard(a) < rankCard(b)); 

	}

	int rankCard(string c) {

		string rank = c[0..2] == "10" ? "10" : c[0..1];
		
		for(int i = 0; i < r.length; i++)
			if(rank == r[i]) return i + 1;
		return -1;
	}

	int cardSuit(string c) {

		string suit = c[$-1..$];

		for(int i = 0; i < s.length; i++)
			if(suit == s[i]) return i;
		return -1;
	}

	void printHand(string[] h) {
		
		foreach(string card ; h) 
			writefln("%3s ", card);
	}

	void printHands(string[] h) {

		for(int i = 0; i < h.length; i++) {
			writefln("%3s", h[i]);
			write(i == 4 ? " | " : " ");
		}
		writeln();
	}
}
