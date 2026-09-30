import java.io.File;
import java.io.FileNotFoundException;
import java.lang.String;
import java.util.Scanner;
import java.util.Random;
import java.util.Arrays;
import java.util.ArrayList;
import java.util.Collections;

public class cards {

	private ArrayList<String> deck = new ArrayList<>(1);
	private ArrayList<String> hand = new ArrayList<>();
	private ArrayList<ArrayList<String>> combos = new ArrayList<>();
	private ArrayList<ArrayList<String>> ds = new ArrayList<>();

	private String[] s = {"D", "C", "H", "S"};
	private String[] r = {"2","3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"};
	
	private Random rand;
	
	public cards(String cardFile) {fileHandling(cardFile);}

	public cards() {
		long seed = System.currentTimeMillis();
		rand = new Random(seed);
	}

	public void shuffle() {
		int place;
		
		for(int i = 0; i < 13; i++) {
			for(int j = 0; j < 4; j++) {
				String cardName = r[i] + s[j];
				deck.add(cardName);
			}
		} 
		
		Collections.shuffle(deck, rand);
		printHand(deck);
	}

	public void chooseHand() {

		if(!deck.isEmpty()) {
			hand = new ArrayList<>(deck.subList(0, 7));
			printHand(hand);	
		}
	}

	public void handCombinations() {

		int n = hand.size();

		for(int i = 0; i < n; i++) {
			for(int j = i + 1; j < n; j++) {
				ArrayList<String> handCombo = new ArrayList<>();
				ArrayList<String> d = new ArrayList<>();
				for(int k = 0; k < n; k++) {
					if(k != i && k != j) {
						handCombo.add(hand.get(k));
					}
				}
				d.add(hand.get(i));
				d.add(hand.get(j));
				ds.add(d);
	
				combos.add(handCombo);
				printHands(handCombo);
				printHands(d);
				System.out.println();
			}
		}
	}

	public void handScore() {

		for(int i = 0; i < combos.size(); i++) {
			sortHand(combos.get(i));
			sortHand(ds.get(i));
			printHands(combos.get(i));
			printHands(ds.get(i));
			System.out.printf(" - %s%n", scoring(combos.get(i)));		
		}

		System.out.println();
	}

	public void printHand(ArrayList<String> h) {
		
		for(final String card : h) 
			System.out.printf("%3s ", card);
		
		System.out.println();
	}

	private void sortHand(ArrayList<String> h) {
 
		Collections.sort(h, (a, b) -> Integer.compare(rankCard(a), rankCard(b)));	
	}

	private void fileHandling(String cardFile) {
		
		File file = new File(cardFile);

		if(!file.exists()) {
			System.out.printf("%s does not exist.%n", cardFile);
			System.exit(0);
		}


		try(Scanner s = new Scanner(file).useDelimiter(",")) {	
			while(s.hasNext()) {
				hand.add(s.next().trim());
			}

			for(final String c : hand) {
				if(Collections.frequency(hand, c) > 1) {
					System.out.printf("\n*** File: %s%n", cardFile); 
					printHand(hand);
					System.out.printf("%n*** DUPLICATED CARD FOUND IN DECK ***%n");
					System.out.printf("*** DUPLICATE: %3s ***%n", c);
					System.exit(0);
				}
			}

			s.close();

		} catch (FileNotFoundException e) {

			System.out.printf("%s not found%n", cardFile);
		}
	}

	private String scoring(ArrayList<String> h) {

		int pairs = 0;

		boolean high = false;
		boolean fok = false;
		boolean tok = false;
		boolean flush = true;
		boolean straight = true;
	
		int[] scores = new int[15];
		Arrays.fill(scores, 0);

		ArrayList<Integer> val = new ArrayList<>();

	
		for(final String cards : h) {
			int cr = rankCard(cards); 
			scores[cr]++;
			val.add(cr);
		}
		
		char firstSuit = h.get(0).charAt(h.get(0).length() - 1);

		for(final String card : h) {
			if(card.charAt(card.length() - 1) != firstSuit) {
				flush = false; break;
			}
		}		

		Collections.sort(val);
		boolean low = val.equals(new ArrayList<>(Arrays.asList(2, 3, 4, 5, 14)));

		if(low) {straight = true;}
			
		else {
		for(int i = 1; i < val.size(); i++) {

			if(val.get(i) != val.get(i - 1) + 1) {
				straight = false; break;
			}
		}}

		for(int i = 2; i <= 14; i++) {

			if(scores[i] == 2) {pairs++;}
			else if(scores[i] == 3) {tok = true;}
			else if(scores[i] == 4) {fok = true;}
		}


		if(val.get(0) == 10) {high = true;}


		if(high && straight && flush) {return "Royal Straight Flush";}
		if(straight && flush) {return "Straight Flush";}
		if(fok) {return "Four of a Kind";}
		if(tok && pairs == 1) {return "Full House";}
		if(flush) {return "Flush";}
		if(straight) {return "Straight";}
		if(tok) {return "Three of a Kind";}
		if(pairs == 2) {return "Two Pair";}
		if(pairs == 1) {return "Pair";}

		return "High Card";
	}

	private int rankCard(String c) {

		String rank;
	
		rank = c.substring(0, 2).equals("10") ? "10" : c.substring(0, 1);
		
		for(int i = 0; i < r.length; i++) {
			if(rank.equals(r[i])) {return i + 2;}
		}

		return -1;
	}

	private int cardsSuit(String c) {

		String suit = c.substring(c.length() - 1);

		for(int i = 0; i < s.length; i++) {
			if(suit.equals(s[i])) {return i;}
		}

		return -1;
	}

	private void printHands(ArrayList<String> h) {

		for(int i = 0; i < h.size(); i++) { 
			System.out.printf("%3s", h.get(i) + (i == 4 ? " | " : " "));
		}
	}

}

