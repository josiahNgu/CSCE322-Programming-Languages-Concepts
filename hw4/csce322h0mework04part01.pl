% will be successful when the number of Wilds (w- and wd) in
% the deck is at least as large as the number of players in the game.
wildsAndPlayers(Deck,Hands):- 
 count(Deck,X),
 length(Hands, Y),
  X >= Y.

count([],0).
count([(w,_)|T],N) :- count(T,N1), N is N1 + 1.
count([X|T],N) :- X \= w, count(T,N).
