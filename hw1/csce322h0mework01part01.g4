grammar csce322h0mework01part01;

uno  : (section)* {System.out.println("End of UNO File");} EOF;  
section: AREA SECTIONSTART INPUTSTART CARD* INPUTEND  SECTIONEND
       | AREA SECTIONSTART  INPUTSTART players* INPUTEND SECTIONEND;
players: (CARD+) ASTERIK?;

AREA:[!][ ]?[a-z]+ {
    System.out.println("Area: " + getText());}
;
SECTIONSTART: '>>'{System.out.println("Start of Section");}; 
SECTIONEND: '<<' {System.out.println("End of Section");};
CARD: [rgywb-][0-9rsd-]* {System.out.println("Card: " + getText());};
ASTERIK:'*'{System.out.println("End of Hand");};
INPUTEND
: '$' {System.out.println("End of List");}
| '}'{System.out.println("End of Hands");};
INPUTSTART
: '^' {System.out.println("Start of List");}
| '{' {System.out.println("Start of Hands");}
;
SPACE
 : (' ' | '\t' | '\r' | '\n') {skip();}
 ;