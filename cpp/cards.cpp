#include <string>
#include <algorithm>
#include <vector>
#include <iostream>
#include <fstream>
#include <ctime>
#include <cstdlib>
#include "cards.h"

using namespace std;

vector<string> deck(1);
vector<string> hand;
vector<vector<string>> combos;
vector<vector<string>> ds;

fstream file;

string s[] = {"D", "C", "H", "S"};
string r[] = {"2","3","4","5","6","7","8","9","10","J", "Q", "K", "A"};

cards::cards() {srand(time(0));}

cards::cards(string cardFile) {fileHandling(cardFile);}

void cards::shuffle(){

	for(int i = 0; i < 13; i++) {

		for(int j = 0; j < 4; j++) {
			
			int place = rand() % deck.size();		
			string cardName = r[i] + s[j];
			deck.insert(deck.begin() + place, cardName);
		}
	}
	
	for(const auto& card : deck) {
		cout << card << " ";
	}
	cout << endl << endl;
}

void cards::chooseHand() {

	if(!deck.empty()) {

		for(int i = 0; i < 7; i++) {
			hand.push_back(deck.at(i));
			cout << deck.at(i) << " ";
		}
	}
	
	cout << endl;
}

//Handles files for input hand
void cards::fileHandling(string cardFile) {
	
	string cardData; 
	string card; 

	file.open(cardFile);
	
	if(!file.is_open()) {
		cout << cardFile << " does not exist." << endl;
		return;
	}

	getline(file, cardData);

	cout << cardData << endl;
	cout << endl;

	for(char c : cardData) {
		if(c == ',') {
			hand.push_back(card);
			card.clear();
		}
		else if( c != ' ') card += c;
	}

		
	if(!card.empty()) hand.push_back(card);

	
	file.close();
} 

//Determines and prints all possible hand combinations
void cards::handCombinations() {
	int n = hand.size();
	
	for (int i = 0; i < n; i++) {
		for (int j = i + 1; j < n; j++) {
			vector<string> handCombo;
			vector<string> d;
			for (int k = 0; k < n; k++) {
				if (k != i && k != j) 
					handCombo.push_back(hand[k]);
				
          		}
			d.push_back(hand[i]);
                        d.push_back(hand[j]);
			ds.push_back(d);

			combos.push_back(handCombo);
			printHand(handCombo);
			printHand(d);
			cout << endl;
			
        	}
	}
	cout << endl;
}

//Prints 7 hand combos and their scores
void cards::handScore() {
	
	for(int i = 0; i < combos.size(); i++) {
		sortHand(combos[i]);
		sortHand(ds[i]);
		printHand(combos[i]);
		printHand(ds[i]);
		cout << " -- " << scoring(combos[i]);
		cout << endl;	
	}
	cout << endl;
}

string cards::scoring(vector<string> h) {
	
	int scores[15] = {0};
	vector<int> val;

	bool flush = true;
	bool straight = true;

	int pairs = 0;
	bool tok = false;
	bool fok = false;
	bool high = false;

	for(const string & cards : h) {
		int cr = rankCard(cards);
		scores[cr]++;	
		val.push_back(cr);
	}

	//Checks if flush
	for(int i = 1; i < h.size(); i++) {
		if(h[i].back() != h[0].back()) {
			flush  = false; break;
		}
	}

	sort(val.begin(), val.end());

	//checks if straight
	for(int i = 1; i < h.size(); i++) {
		if(val[i] != val[i - 1] + 1) {
			straight = false; break;
		}
	}
	
	//checks for pairs/three of kind/full house
	for(int i = 2; i <= 14; i++) {
		if(scores[i] == 2) pairs++;
		else if (scores[i] == 3) tok = true;
		else if(scores[i] == 4) fok = true;
	}
	
	if(val[0] == 10) high = true;
		
	//Returns hand type
	if(high && straight && flush) return "Royal Straight Flush";
	if(straight && flush) return "Stright Flush";
	if(fok) return "Four of a Kind";
	if(tok && pairs == 1) return "Full House";
	if(flush) return "Flush";
	if(straight) return "Straight";
	if(tok) return "Three of a Kind";
	if(pairs == 2) return "Two Pair";
	if(pairs == 1) return "Pair";

	return "High Card";

}

void cards::sortHand(vector<string>& h) {

	sort(h.begin(), h.end(), [&](const string& a, const string& b) {
		
		return rankCard(a) < rankCard(b);
			
	});
}

int cards::rankCard(string c) {

	string rank;

	c.substr(0, 2) == "10" ? rank = "10" : rank = c.substr(0, 1);

	for(int i = 0; i < 13; i++) 
		if(rank == r[i]) return i + 1;

	return -1;

}

int cards::cardSuit(string c) {
	
	string suit = c.substr(1, 1);

	for(int i = 0; i < 4; i++) 
		if(suit == s[i]) return i;

	return -1;

}
void cards::printHand() {
	for(int i = 0; i < hand.size(); i++)
		i == 4 ? cout << hand.at(i) << " | " : cout << hand.at(i) << " ";

	cout << endl; 
}

	
void cards::printHand(vector<string> h) {
	
	for(int i = 0; i < h.size(); i++) 
		i == 4 ? cout << h.at(i) << " | " : cout << h.at(i) << " ";
}
