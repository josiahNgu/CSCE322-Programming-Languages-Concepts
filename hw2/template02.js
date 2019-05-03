var helpers = require( './helpers' );
var part = require( './csce322h0mework02part02' );

var deck = helpers.readDeckFile('test02.deck.uno');
var discard = helpers.readDiscardFile('test02.discard.uno');
var hands = helpers.readHandsFile('test02.hands.uno');
var beforeDe = deck.slice(0);
var beforeDi = discard.slice(0);
var beforeHa = hands.slice(0);

var theFunction = part.onePlayerManyMoves( deck , discard );
var after = theFunction( hands[0] );
console.log( 'discard' );
helpers.printDiscard( after.discard );
console.log( 'deck' );
helpers.printDeck( after.deck );
var afterHands = [];
afterHands.push( after.hand );
console.log( 'hands' );
helpers.printHands( afterHands );
