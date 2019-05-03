longestRun(Hand,Discard,[(-,-)]).


listLength([], 0).
listLength([H|T], N) :- listLength(T, N1), N is N1+1.
