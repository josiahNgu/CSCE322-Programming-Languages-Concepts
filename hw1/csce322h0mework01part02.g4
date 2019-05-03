grammar csce322h0mework01part02;
@members {
    int totalCards = 0;
    int players = 0;
    int discardCard = 0;
    boolean error = false;
}
uno: hands (discard | deck)* semanticError EOF;
hands:
	AREA SECTIONSTART INPUTSTART players* INPUTEND SECTIONEND;
deck: DECK SECTIONSTART INPUTSTART deckCard INPUTEND SECTIONEND;
discard:
	DISCARD SECTIONSTART INPUTSTART discardCard* INPUTEND SECTIONEND;

players: card+ ASTERIK? {players++;};
card: (CARD | MCARD) {totalCards++;};
deckCard: card+;
discardCard: CARD {discardCard++; totalCards++;};
semanticError:
	{
        if( players < 2 || players > 10) {
            error = true;
            System.out.println("TROUBLE: Semantic Rule 1 Violated.");
        }
        if (discardCard > totalCards*0.1){
            error = true;
            System.out.println("TROUBLE: Semantic Rule 2 Violated.");
        }
        if(error == false ){
            System.out.println(discardCard + " cards have been played.");
        }
};
DISCARD: '!discard' | '! discard';
MCARD: [rgywb][-]{skip();};
CARD: [rgywb][0-9rsd]*;
DECK: '!deck' | '! deck';
AREA: [!][ ]? [a-z]+;
SECTIONSTART: '>>';
SECTIONEND: '<<';
ASTERIK: '*';
INPUTEND: '$' | '}';
INPUTSTART: '^' | '{';
SPACE: (' ' | '\t' | '\r' | '\n') {skip();};