% The query majorityOdd(Deck) will be successful when the majority of cards in the deck have an odd
% number as the symbol.
majorityOdd(Deck):-
  count(Deck,OddCard),
  length(Deck,DeckLength),
   OddCard >DeckLength.

count([],0).
count([(_,E2)|T],N) :-
  integer(E2),
  1 is mod(E2,2),
  count(T,N1),
  N is N1 +1.

 count([X|T],N) :- X\=z ,count(T,N).


