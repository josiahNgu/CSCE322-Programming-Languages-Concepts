module.exports = {
  onePlayerManyMoves: onePlayerManyMoves
}

var helpers = require( './helpers' );

function onePlayerManyMoves( deck , discard ){
  
  

  function whatever( hand ){

    function hasMove(){
      if(deck.length > 0 && hand.length > 0){
        return true;
        }
        //fix this function
      if(hand.length > 0 && deck.length == 0){
        // console.log(hand.length);
        var temp=0;
        for(var j =0; j<hand.length;j++){
          // console.log(j+ hand[j]);
          if((hand[j][0] == discard[0][0])){
            temp=1;
          }
          if(hand[j][1] == discard[0][1]){
            temp=1;
          }
         
        }
        if(temp===1){
          return true;
        }
    }
    else {
      return false;
    }
    }
       while(hasMove()){
      var check =0;
      //check to extends W4
      //fix more than 1 wild draw need to print twice on the last one
      if(discard.length>1){
        var wild =1;
      if(discard[1][0] == 'w' && discard[1][1] == 'd'){
        for (var i=0;i<hand.length;i++){
            if((hand[i][0] == 'w' && hand[i][1] == "d")) {
              discard.unshift(hand[i]);
              hand.splice(i,1);
              discard.unshift(hand[0][0].concat('-'));
              wild++;
              }
              if(i == hand.length-1 && hand[0][0] == "w"){
                for(var j =1; j<hand.length; j++){
                  if(hand[j][0] !== "w"){
                    discard.unshift(hand[j][0].concat('-'));
                    check =999;
                    break;
                  }
                }
              }
              if (i == (hand.length) && hand[0][0]!== "w"){
                discard.unshift(hand[0][0].concat('-'));
                check =999;
              }
              if (i == (hand.length-1) && hand[0][0]!== "w"){
                discard.unshift(discard[0][0].concat('-'));
                check =999;

                break;
              }
           }
           if(deck.length >= wild*4){
           for(var i =0; i<wild*4;i++){
             hand.push(deck[0]);
             deck.splice(0,1);
            }
          }
        }
        }

      //check consecutive color draw
      function drawCard(position){
        discard.unshift(hand[position]);
        hand.splice(position,1);
        var count =1;
        // i loop not updating to hand.length
        for (var i=0;i<hand.length;i++){
          if(hand[i][0] !== "w" && hand[i][1] == "d") {
            discard.unshift(hand[i]);
            hand.splice(i,1);
            count++;
            i=0;
            }     
         }
         if(hand.length>0){
          discard.unshift(discard[0][0].concat('-'));
         for(var j =0;j<count*2;j++){
           hand.push(deck[0]);
           deck.splice(0,1);
         }
        }
    }

      //check if color match
      if(check === 0){
        check =1;

        if(discard[0][0] !== "w"){
        for(var i=0; i<hand.length;i++){
          if(discard[0][0] == hand[i][0] && hand[i][1] !== "d"){
            discard.unshift(hand[i]);
            hand.splice(i,1);
            check = 999;
            break;
            }
            //color draw
            if (discard[0][0] == hand[i][0] && hand[i][1] == "d"){
              check =999;
              drawCard(i);
              break;
            }
          }
        }
      }
        //check for draw 4 card to put on discard
        if(check === 1) {
          check = 2;
          for(var i=0;i<hand.length;i++){
            if(hand[i][0] == "w" && hand[i][1] == "d") {
              discard.unshift(hand[i]);
              hand.splice(i,1);
              if(hand[0][0] !== "w"){
                discard.unshift(hand[0][0].concat('-'));
              }
              if(hand[0][0] == "w"){
                for(var j =1; j<hand.length; j++){
                  if(hand[j][0] !== "w"){
                    discard.unshift(hand[j][0].concat('-'));
                    break;
                  }
                }
              }
              check =999;
              break;
              }
           }
        }

        //check if the # match
        if (check === 2){
          check=3;
          //console.log("match number");
          for(var i=0; i<hand.length;i++){
          if(discard[0][1] == hand[i][1] && discard[0][1] !== "-"){
            discard.unshift(hand[i]);
            hand.splice(i,1);
            check = 999;
            break;
              }
          }
        }

        // play left most wild
        if(check === 3){
          check =4;
          for(var i=0;i<hand.length;i++){
            if((hand[i][0] == "w" && hand[i][1] == "-") ) {
              discard.unshift(hand[i]);
              hand.splice(i,1);
              if(hand.length>0){
              discard.unshift(hand[0][0].concat('-'));
              }
              check =999;
              break;
              }
           }
        }

        //draw from deck
        if(check === 4){
            hand.push(deck[0]);
            deck.splice(0,1);
        }

        if(hand.length === 0){
          discard.unshift('--');
        }
        
      }


return { deck:deck , discard:discard , hand:hand };
  }

  return whatever;
}
