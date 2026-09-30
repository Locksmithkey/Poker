A set of test hands are also provided in the "testDecks" folder for testing

hands: dup RSF SF FOK fullHouse flush STR TOK twoPair pair highCard

For compiling poker program for each langauge:

=== C++ ===

Compiling: g++ poker.cpp -o poker

Randomized Sort: ./poker 

Using File: ./poker ../testDecks/{hand} // Or customfile.

=== Java ===

Compiling: javac poker.java cards.java // Or javac *.java if only files in directory.

Randomized Sort: java poker

Using File: java poker ../testDecks{hand} // Or custom file

=== Python ===

Compiling: python3 poker.py

Randomized Sort: python3 poker.py

Using File: python3 poker.py ../testDecks/{hand} // Or custom file

=== D ===

Compiling: gdc poker.d cards.d -o poker // Or gdc *.d if only two files in directory

Randomized Sort: ./poker 

Using File: ./poker ../testDecks/{hand} // Or custom file

=== C# ===

Compiling: msc poker.cs cards.cs // Or mcs *.cs if only files in directory

Randomized Sort: mono poker.exe

Using File: mono poker.exe ../testDecks/{hand} // Or custom file
