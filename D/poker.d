module main;

import std.stdio;
import std.string;
import poker.cards;

void main(string[] args) {

	poker.cards p;

	if(args.length > 1) {
		writefln("\n*** USING TEST DECK ***");
		writefln("\n*** File: %s", args[1]);
		
		p = new cards(args[1]);

	} 
	
	else {
		p = new cards;

		writefln("\n*** USING RANDOMIZAED DECK OF CARDS ***");
		writefln("\n*** Shuffled 52 card deck: ");
		p.shuffle();

		writefln("\n*** Here is the hand");
		p.chooseHand();

		writeln();
	}

	writefln("\n+++ Hand Combinations...");
	p.handCombinations();

	writefln("\n--- HIGH HAND ORDER ---");
	p.handScore();


}
