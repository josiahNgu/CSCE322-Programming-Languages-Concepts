var helpers = require( './helpers' );
var part = require( './csce322h0mework02part04' );

var deck = helpers.readDeckFile('test02.deck.uno');
var discard = helpers.readDiscardFile('test02.discard.uno');
var hands = helpers.readHandsFile('test02.hands.uno');
var beforeDe = deck.slice(0);
var beforeDi = discard.slice(0);
var beforeHa = hands.slice(0);

var theFunction = part.manyPlayersManyMoves( deck , discard );
var after = theFunction( hands );
console.log( 'discard' );
helpers.printDiscard( after.discard );
console.log( 'deck' );
helpers.printDeck( after.deck );
console.log( 'hands' );
helpers.printHands( after.hands );
