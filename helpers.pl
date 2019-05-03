:- module( helpers,
	 [ readUnoFile/4
	 , printGame/3
	 ]
    ).

readUnoFile(File,Deck,Discard,Hands):-
    open(File,read,Input),
    read(Input,Deck),
    read(Input,Discard),
    readHands(Input,Hands),
    close(Input).

readHands(Input,[]):-
    at_end_of_stream(Input),
    !.
readHands(Input,[Hand|Hands]):-
    \+ at_end_of_stream(Input),
    read(Input,Hand),
    readHands(Input,Hands).

printGame(Deck,Discard,Hands):-
    writeln(deck),
    writeln(Deck),
    writeln(discard),
    writeln(Discard),
    writeln(hands),
    printHands(Hands).

printHands([]).
printHands([H|Hs]):-
    writeln(H),
    printHands(Hs).


