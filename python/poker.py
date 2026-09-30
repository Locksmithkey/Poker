from cards import Cards
import sys
    
def main():

    if len(sys.argv) > 1:
        print("\n*** USING TEST DECK ***")
        print(f"\n*** File: {sys.argv[1]} ***")

        p = Cards(sys.argv[1])
        
    else:
        print("\n*** USING RANDOMIZED DECK OF CARDS ***")
        print("\n888 Shhuffled 52 card deck: ")

        p = Cards()
        print("\n*** Here is the hand ***")
        p.chooseHand()
        print()

    print("\n** Hand Combinations...")
    p.handCombinations()
    
    print("\n--- HIGH HAND ORDER ---")
    p.handScore()


if __name__ == "__main__":
    main()
