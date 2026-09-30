import java.lang.*;
import java.io.*;

public class poker {
	public static void main(String[] args) {

		cards poker;

		System.out.println("\n*** P O K E R  H A N D  A N A L Y Z E R***\n");

		if(args.length > 0) {
			
			poker = new cards(args[0]);
			System.out.printf("%n*** USING TEST DECK ***%n%n*** File : %s%n", args[0]);			
		}
		else {

			poker = new cards();

			System.out.println("\n*** USING RANDOMIZED DECK OF CARDS ***\n");
			System.out.println("\n*** Shuffled 52 card deck: \n");
			poker.shuffle();
		
			System.out.println("\n*** Here is the hand\n");
			poker.chooseHand();

			System.out.println();
		}

		System.out.println("\n*** Hand Combinations...\n");
		poker.handCombinations();

		System.out.println("--- HIGH HAND ORDER ---\n");
		poker.handScore();
	}
}
