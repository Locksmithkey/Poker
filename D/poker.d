module poker;

import Cards : Cards;

import std.stdio;
import std.string;

void main(string[] args) {
	
	Cards p;

	writeln("\n*** P O K E R  H A N D  A N A L Y Z E R ***\n");

	if(args.length > 1) {

		p = new Cards(args[1]);
	
		writefln("\n*** USING TEST DECK ***");
		writefln("\n*** File: %s", args[1]);
		p.printHand();
	} 
	
	else {
		p = new Cards();

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
