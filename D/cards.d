module Cards;

import std.random;
import std.file;
import std.string;
import std.stdio;
import std.algorithm;
import std.container.array;
import core.stdc.stdlib : exit;

class Cards {

	string[] deck, hand;
	string[][] ds, combos;
	
	string[] s = ["D", "C", "H", "S"];
	string[] r = ["2", "3", "4", "5", "6","7","8", "9", "10", "J", "Q", "K", "A"]; 

	Random rand;

	this() {rand = Random(unpredictableSeed);}

	this(string cardFile) {fileHandling(cardFile);}

	void  shuffle() {
	
		foreach(rank ; r) {
			foreach(suit ; s) {
				deck ~= rank ~ suit;  
			}
		}

		deck.randomShuffle(rand);
		printHand(deck);
	}

	void chooseHand() {
		
		if(!deck.empty)
			hand = deck[0..7];

		printHand(hand);
	}

	void fileHandling(string cardFile) {

		if(!exists(cardFile)) {
			writefln("%3s does not exist.\n", cardFile);
			exit(1);
		}

		File file = File(cardFile, "r");

		string cardData = strip(file.readln());

		hand = cardData.split(", ");

		foreach(c ; hand) {
			if(count(hand, c) > 1) {
				writefln("*** File: %s", cardFile);
				printHand();
				writeln("\n*** ERROR - DUPLICATED CARD FOUND IN DECK ***\n");
				writefln("*** DUPLICATE %s ***\n", c);
				exit(1);
			}
		}
	}

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

			writefln("- %s", scoring(combos[i]));
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
		bool aceLow = val == [2, 3, 4, 5, 14]; 

		if(aceLow) {
			straight = true;
		}
		else {

		for(int i = 1; i < val.length; i++) {
			if(val[i] != val[i - 1] + 1) {
				straight = false; break;
			}
		}}

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
	
		string rank = c.length == 3 ? "10" : c[0..1];
	
		for(int i = 0; i < r.length; i++)
			if(rank == r[i]) return i + 2;
		return -1;
	}

	int cardSuit(string c) {

		for(int i = 0; i < s.length; i++)
			if(c[$-1..$] == s[i]) return i;
		return -1;
	}

	void printHand(string[] h = null) {
		
		if(h is null) h = hand;

		foreach(string card ; h) 
			writef("%3s ", card);
		writeln();
	}

	void printHands(string[] h) {

		for(int i = 0; i < h.length; i++) {
			writef("%3s", h[i]);
			write(i == 4 ? " | " : " ");
		}
	}
}
