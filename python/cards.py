import random
import csv

class Cards:
    
    def __init__(self, cardFile = None):

        self.deck = []
        self.hand = []
        self.ds = []
        self.combos = []
        
        self.suit =  ["D", "C", "H", "S"]
        self.rank = ["2", "3", "4", "5", "6", "7", 
                    "8", "9", "10", "J", "Q", "K", "A"]
        
        if cardFile is None:
            self.shuffle()
        else: 
            self.fileHandling(cardFile)

    def shuffle(self):
        for r in self.rank:
            for s in self.suit:
                self.deck.append(r + s)

        random.shuffle(self.deck);
        self.printHand(self.deck)

    def chooseHand(self):
        if len(self.deck) > 0:
            self.hand = self.deck[:7]
        self.printHand(self.hand)
        

    def fileHandling(self, cardFile):
        try:
            with open(cardFile, "r") as file:
    
                cardData = csv.reader(file)

                for row in cardData:
                    for card in row:
                        card = card.strip()
            
                        if card in self.hand:
                            self.printHand()
                            print("\n***ERROR -  DUPLICATED CARD FOUND IN DECK ***")
                            print(f"*** DUPLICATE: {card:>3} ***")
                            exit()

                        self.hand.append(card)


        except FileNotFoundError:
            print(f"{cardFile} does not exist.")
            exit()

        self.printHand(self.hand)

    def handCombinations(self):
        n = len(self.hand)

        for i in range(n):
            for j in range(i + 1, n):
    
                handCombo = []
                d = []

                for k in range(n):
                    if k != i and k != j:
                        handCombo.append(self.hand[k])

                d.append(self.hand[i])
                d.append(self.hand[j])
                self.ds.append(d)
                self.combos.append(handCombo)

                self.printHands(handCombo)
                self.printHands(d)
                print()


       
    def handScore(self):
        for i in range(len(self.combos)):
            self.sortHand(self.combos[i])
            self.sortHand(self.ds[i])
            
            self.printHands(self.combos[i])
            self.printHands(self.ds[i])
            
            print(f" - {self.scoring(self.combos[i])}")

    def scoring(self, h):
        pairs = 0

        fok = False
        tok = False
        flush = True
        straight = True

        scores = [0] * 15
        val = []

        for card in h:
            cr = self.rankCard(card)
            scores[cr] += 1
            val.append(cr)

        for card in h:
            if card[-1] != h[0][-1]:
                flush = False
                break

        val.sort()
       
        for i in range(1, len(val)):
            if val[i] != val[i - 1] + 1:
                straight = False
                break

        for i in range(2, 15):
            if scores[i] == 2: pairs += 1
            elif scores[i] == 3: tok = True
            elif scores[i] == 4: fok = True

        royal = val == [10, 11, 12, 13, 14]

        if royal and flush: return "Royal Straight Flush"
        if straight and flush: return "Straight Flush"
        if fok: return "Four of a Kind"
        if tok and pairs == 1: return "Full House"
        if tok: return "Three of a Kind"
        if flush: return "Flush"
        if straight: return "Straight"
        if pairs == 2: return "Two Pair"
        if pairs == 1: return "Pair"

        return "High Card"

    def sortHand(self, h):
        h.sort(key=self.rankCard)

    def rankCard(self, c):
        rank = "10" if len(c) == 3 else c[0]

        for i in range(len(self.rank)):
            if rank == self.rank[i]:
                return i + 2
        return -1

    def cardSuit(self, c):
        for i in range(len(self.suit)):
            if c[-1] == self.suit[i]:
                return i
        return -1

    def printHand(self, h = None):
        if h is None: h = self.hand
        
        for card in h:
            print(f"{card:<3} ", end="")
        print()        
    
    def printHands(self, h):
        for i in range(len(h)):
            print(f"{h[i]:<3}", end="")
            print(" | " if i == 4 else " ", end="")
