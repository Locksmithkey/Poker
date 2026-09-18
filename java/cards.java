package poker;

import java.io.*;
import java.util.Scanner;
import java.util.Random;
import java.util.Vector;
import java.util.ArrayLis;
import java.lang.String;
import java.util.Collections;

public class cards {

	private String cardFile;
	private ArrayList<String> deck = new ArrayList<>(1);
	private ArrayList<String> hand;
	private AraayList<ArrayList<String>> combos;
	private ArrayList<ArrayList<String>> ds;

	private String[] s = {"D", "C", "H", "S"};
	private String[] r = {"2","3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"};
	
	cards(String cardFile) {
		this.cardFile = cardFile;
	}

	cards() {
		long seed = System.currentTimeMillis();
		Random rand = new Random(seed);
	}

	public void shuffle() {
		
		for(int i = 0; i < 13; i++) {
			for(int j = 0; j < 4; j++) {
				int place = rand.nextInt() % deck.size();
				String cardName = r[i] + s[j];
				deck.add(place, cardName);
			}
		} 

		for(final String card : deck)
			System.out.printf("%s ", card);

		System.out.println();

	}

	public void chooseHand() {

		if(!deck.isEmpty()) {
			hand = deck.subList(0, 7);
			
			for(int i = 0; i < hand.size(); i++)
				System.out.printf(
	
		}
				

	}

	public void handCombinations() {}

	public void handScore() {}

	private void sortHand(Vector<String> &h) {
 
		


	}

	

	private void fileHandling(String cardFile) {
		
		string cardData;
		File file = new File(cardFile);

		if(!file.exists()) {
			System.out.printf("%s does not exist.\n", cardFile);
			return;
		}

		
	}

	private String scoring(Vector<String> h) {}

	private int rankCard(String c) {

		String rank;
	
		c.subString(0, 2) == "10" ? rank = "10" : rank = c.subString(0, 1);

		return ranks.indexOf(rank);
	}

	private int cardsSuit(String c) {

		string suit = c.subString(1, 1);

		return suits.indexOf(suit);
	}

	public void printHand(ArrayList<String> h) {

		for(int i = 0; i < h.size(); i++) 
			i == 4 ? System.out.print(h[ + " | ") : System.out.print(h[i] + " \n");
	}























}

