using System;

class poker {
static void Main(string[] args) {

	Cards p;

	Console.WriteLine(args.Length);
	Console.WriteLine("\n*** P O K E R  H A N D  A N A L Y Z E R ***n");

	if(args.Length > 0) {
	
		Console.WriteLine($"\n*** USING TEST DECK ***\n");
		Console.WriteLine($"\n***File: {args[0]}\n");

		p = new Cards(args[0]);
	}
	else {

		Console.WriteLine("\n*** USING RANDOMIZED DECK OF CARDS ***\n");
		Console.WriteLine("\n*** Shuffled 52 Card Deck: \n");
		p = new Cards();

		Console.WriteLine("\n*** Here is the hand");
		p.ChooseHand();

		Console.WriteLine();
	}

	Console.WriteLine("\n*** Hand Combinations...");
	p.HandCombinations();
	
	Console.WriteLine("\n--- HIGH HAND ORDER ---\n");
	p.HandScore();
}}
