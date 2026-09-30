using System;
using System.IO;
using System.Linq;
using System.Collections.Generic;

class Cards {

	private List<string> deck = new List<string>();
	private List<string> hand = new List<string>();
	private List<List<string>> combos = new List<List<string>>();
	private List<List<string>> ds = new List<List<string>>();

	private string[] s = {"D", "H", "C", "S"};
	private string[] r = {"2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"};


	public Cards() {Shuffle();}

	public Cards(string cardFile) {FileHandling(cardFile);}

	public void Shuffle() {

		deck.Clear();
		hand.Clear();
		Random rand = new Random();

		for(int i = 0; i < r.Length; i++) {
			for(int j = 0; j < s.Length; j++) {
				string cardName = r[i] + s[j]; 
				deck.Add(cardName);
			}
		}
	
		int n = deck.Count;
		while( n > 1) {
			n--;
			int place = rand.Next(n + 1);
			string temp = deck[place];
			deck[place] = deck[n];
			deck[n] = temp;
		}
		PrintHand(deck);
	}

	public void ChooseHand() {

		if(deck.Count > 0) {
			hand = deck.GetRange(0, 7);
			PrintHand();
		}
	}

	public void HandCombinations(){

		combos.Clear();
		ds.Clear();

		int n = hand.Count;

		for(int i = 0; i < n; i++) {
			for(int j = i + 1; j < n; j++) {
				List<string> handCombo = new List<string>();
				List<string> d = new List<string>();

				for(int k = 0; k < n; k++) {
					if(k != i && k != j)
						handCombo.Add(hand[k]);
				} 

				d.Add(hand[i]);
				d.Add(hand[j]);
				combos.Add(handCombo);
				ds.Add(d);
				PrintHands(handCombo);
				PrintHands(d);
				Console.WriteLine();
			}
		}
	}

	public void FileHandling(string cardFile) {

		if(!File.Exists(cardFile)) {
			Console.WriteLine($"{cardFile} does not exist.\n");
			Environment.Exit(0);
		}	

		string cardData = File.ReadAllText(cardFile);

		string[] cards = cardData.Split(',');

		foreach(string card in cards) {
			hand.Add(card.Trim());
		}

		foreach(string card in hand) {
			int freq = hand.Count(x => x == card);
			if(freq > 1) {
				PrintHand(hand);
				Console.WriteLine("***ERROR - DUPLICATED CARD FOUND IN DECK ***\n");
				Console.WriteLine($"\n*** DUPLICATE: {card,3} ***\n");
				Environment.Exit(0);
			}
		}
	}

	public void HandScore() {

		for(int i = 0; i < combos.Count; i++) {
			SortHand(combos[i]);
			SortHand(ds[i]);
			PrintHands(combos[i]);
			PrintHands(ds[i]);

			Console.WriteLine($" - {Scoring(combos[i])}\n");
		}
	
	}

	public void SortHand(List<string> h){

		h.Sort((a, b) => RankCard(a).CompareTo(RankCard(b)));
	}

	public string Scoring(List<string> h){

		int[] scores = new int[15];
	
		List<int> val = new List<int>();

		bool flush = true;
		bool straight = true;
		bool tok = false;
		bool fok = false;
		bool high = false;

		int pairs = 0;


		foreach(var cards in h) {

			int cr = RankCard(cards);
			scores[cr]++;
			val.Add(cr);
		}

		val.Sort();

		for(int i = 1; i < h.Count; i++) {

			if(h[i][h[i].Length - 1] != h[0][h[0].Length - 1]) { 
				flush = false;
				break;
			}
		}

		for( int i = 1; i < val.Count; i++) {

			if(val[i] != val[i - 1] + 1) {
				straight = false;
				break;
			}
		}
		
		for(int i = 2; i <= 14; i++) {
			if(scores[i] == 2) pairs++;
			else if (scores[i] == 3) tok = true;
			else if (scores[i] == 4) fok = true;
		}

		if(val[0] == 10) high = true;

	
		if(high && straight && flush) return "Royal Straight Flush";
		if(straight && flush) return "Straight Flush";
		if(fok) return " Four of a Kind";
		if(tok && pairs == 1) return "Full House";
		if(flush) return "Flush";
		if(straight) return "Straight";
		if(tok) return "Three of a Kind";
		if(pairs == 2) return "Two Pair";
		if(pairs == 1) return "Pair";
	
		return "High Card";
	}

	public int RankCard(string c) {
		
		string rank = c.Length == 3 ? c.Substring(0, 2) : c.Substring(0, 1);

		for(int i = 0; i < r.Length; i++) 
			if(rank == r[i]) return i + 2;
		return -1;
	}
		
	public int CardSuit(string c) {

		for(int i = 0; i < s.Length; i++) 
			if(c[c.Length - 1].ToString() == s[i]) return i;	
		return -1;
	}
	
	public void PrintHand(List<string> h = null) {

		if(h == null) h = hand;

		foreach(var c in h) 
			Console.Write($"{c,3} ");

		Console.WriteLine();
	}

	public void PrintHands(List<string> h) {
	
		for(int i = 0; i < h.Count; i++) {
			Console.Write($"{h[i],3}");
			Console.Write(i == 4 ? " | " : " ");
		}
	}
}
