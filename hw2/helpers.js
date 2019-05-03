module.exports = {
  readDeckFile:readDeckFile,
  readDiscardFile:readDiscardFile,
  readHandsFile:readHandsFile,
  printDeck:printDeck,
  printDiscard:printDiscard,
  printHands:printHands
}

function readDeckFile( file )
{
  var text;
  var deck = [];
  var rows = [];
  var cards = [];
  var filesystem = require( 'fs' );

  text = filesystem.readFileSync( file );
  rows = text.toString().split( "\n" );
  rows.pop();
  
  deck = rows[0].split( ';' );

  for( var d = 0; d < deck.length; d++ ){
cards[d] = [];
cards[d] = deck[d].split( "," );
  }
  
  return cards;
}

function readDiscardFile( file )
{
  var text;
  var discard = [];
  var rows = [];
  var cards = [];
  var filesystem = require( 'fs' );

  text = filesystem.readFileSync( file );
  rows = text.toString().split( "\n" );
  rows.pop();
  
  discard = rows[0].split( ';' );

  for( var d = 0; d < discard.length; d++ ){
cards[d] = [];
cards[d] = discard[d].split( "," );
  }
  
  return cards;
}

function readHandsFile( file )
{
  var text;
  var hands = [];
  var rows = [];
  var cards = [];
  var filesystem = require( 'fs' );

  text = filesystem.readFileSync( file );
  rows = text.toString().split( "\n" );
  rows.pop();
  
  for( var h = 0; h < rows.length; h++ ){
hands[h] = rows[h].split( ';' );
cards[h] = [];
for( var c = 0; c < hands[h].length; c++ ){
    cards[h][c] = hands[h][c].toString().split( ',' );
}
  }

  return cards;
}


function printDeck( deck ){
  var row = "";
  for( var c = 0; c < deck.length; c++ ){
row = row + "[" + deck[c][0] + deck[c][1] + "]";
  }
  console.log( row );
}

function printDiscard( discard ){
  var row = "";
  for( var c = 0; c < discard.length; c++ ){
row = row + "[" + discard[c][0] + discard[c][1] + "]";
  }
  console.log( row );
}

function printHands( hands ){
  for( var h = 0; h < hands.length; h++ ){
var row = "";
for( var c = 0; c < hands[h].length; c++ ){
    row = row + "[" + hands[h][c][0] + hands[h][c][1] + "]";
}
console.log( row );
  }
}

