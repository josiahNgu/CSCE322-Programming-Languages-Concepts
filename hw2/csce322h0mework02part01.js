module.exports = {
  onePlayerOneMove: onePlayerOneMove
}

var helpers = require( './helpers' );

function onePlayerOneMove( deck , discard ){
 
  function whatever( hand ){
    var check =0;
    //check for same color
    if(discard[0][0] == "r"||"g"||"b"||"y"){
      if(check === 0){
        check =1;
      for(var i=0; i<hand.length;i++){
        if(discard[0][0] == hand[i][0]){
          discard.unshift(hand[i]);
          hand.splice(i,1);
          check = 999;
          break;
            }
          }
        }
        if(check === 1 ){
          check=2;
          for(var i=0;i<hand.length;i++){
            if((hand[i][0] == "w" && hand[i][1] == "d")) {
              discard.unshift(hand[i]);
              hand.splice(i,1);
              discard.unshift(hand[0][0].concat('-'));
              check =999;
              break;
              }
           }

        }
        //check for same number
        if (check === 2){
          check=3;
          for(var i=0; i<hand.length;i++){
          if(discard[0][1] == hand[i][1]){
            discard.unshift(hand[i]);
            hand.splice(i,1);
            check = 999;
            break;
              }
          }
        }
        //check for w-
       if (check === 3){
        check =4;
        for(var i=0;i<hand.length;i++){
          if((hand[i][0] == "w" && hand[i][1] == "-")) {
            discard.unshift(hand[i]);
            hand.splice(i,1);
            discard.unshift(hand[0][0].concat('-'));
            check =999;
            break;
            }
         }
        }  if(check === 4 ){
              hand.push(deck[0]);
              deck.splice(0,1);
          }
    }

return { deck:deck , discard:discard , hand:hand };
  }

  return whatever;
}
