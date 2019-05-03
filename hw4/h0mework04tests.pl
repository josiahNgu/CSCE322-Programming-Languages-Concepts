printSequences([]).
printSequences([Sequence|Sequences]):-
    writeln(Sequence),
    printSequences(Sequences).

loadHelpers:-
    ['helpers'],
    ['csce322h0mework04part01'],
    ['csce322h0mework04part02'],
    ['csce322h0mework04part03'],
    ['csce322h0mework04part04'].
    
part01:-
    readUnoFile('part01test01.uno',Deck,Discard,Hands),
    printGame(Deck,Discard,Hands),
    wildsAndPlayers(Deck,Hands).
    
part02:-
    readUnoFile('part02test01.uno',Deck,Discard,Hands),
    printGame(Deck,Discard,Hands),
    majorityOdd(Deck).
    
part03:-
    readUnoFile('part03test01.uno',Deck,Discard,[Hand|Hands]),
    printGame(Deck,Discard,[Hand|Hands]),
    setof(Run,longestRun(Hand,Discard,Run),Runs),
    writeln(runs),
    printSequences(Runs).
    
part04:-
    readUnoFile('part04test01.uno',Deck,[Card|Cards],[Hand|Hands]),
    printGame(Deck,[Card|Cards],[Hand|Hands]),
    setof(Next,nextCard(Hand,Card,Next),Nexts),
    writeln(nexts),
    printSequences(Nexts).
    
