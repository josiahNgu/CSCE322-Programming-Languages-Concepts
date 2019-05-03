module.exports = {
  manyPlayersManyMoves: manyPlayersManyMoves
}

var helpers = require( './helpers' );

function manyPlayersManyMoves( deck , discard ){
  
  function whatever( hands ){
    var index=0;
    var reverse=0;
     var temp=31;
    //var temp=true;
     while( temp>0){ 
       //while(temp==true){ 

      if(index== -1){
        index = hands.length-1;
      }
      if(index == hands.length){
        index =0;
      }
    var check =0;

    function nextIndex(){
      if(reverse%2 == 0){
        index++;
        if(index == hands.length){index=0;}
      }
      if(reverse%2 !== 0){
        index --;
        if(index == -1){
          index=hands.length-1;
        }
      }
    }

      //extends W4
      function wild4(){
        if(discard.length>1){
        var wild =1;
        if(discard[1][0] == 'w' && discard[1][1] == 'd'){
          var nextPlayer = 0;
          if(reverse%2 == 0){
            nextPlayer = index+1;
            if(nextPlayer == hands.length){nextPlayer=0;}
          }
          if(reverse%2 !==0){
            nextPlayer = index-1;
            if(nextPlayer == -1){nextPlayer=hands.length-1;}
          }
          for (var i=0;i<hands[nextPlayer].length;i++){
              if((hands[nextPlayer][i][0] == 'w' && hands[nextPlayer][i][1] == "d" )) {
                discard.unshift(hands[nextPlayer][i]);
                hands[nextPlayer].splice(i,1);
                wild++;
                i=-1;
                console.log(hands[nextPlayer]);
                if(hands[nextPlayer].length ==0){temp=false;break;}
                if(hands[nextPlayer].length>0){
                if(hands[nextPlayer][0][0] == "w"){
                  for(var j=0; j<hands[nextPlayer].length;j++){
                    if(hands[nextPlayer][j][0]!== "w"){
                    discard.unshift(hands[nextPlayer][j][0].concat("-"));
                    break;
                    }
                  }
                }
                else if (hands[nextPlayer][0][0] !== "w") {
                  discard.unshift(hands[nextPlayer][0][0].concat("-"));
                }
                if(nextPlayer < hands.length){
                  if(reverse%2 == 0){
                    nextPlayer++;
                    if(nextPlayer == hands.length){
                      nextPlayer=0;
                    }
                  }
                  if(reverse%2 !== 0){
                    nextPlayer--;
                    if(nextPlayer == -1){
                      nextPlayer=hands.length-1;
                    }
                  }
                }
              }
              }
            }
            index = nextPlayer;
            if( hands[index][0][0] == "w" ){
              for(var j=0; j<hands[index].length;j++){
                if(hands[index][j][0]!== "w"){
                discard.unshift(hands[index][j][0].concat("-"));
                break;
                }
              }
              check =999;
            }
            if (hands[index][0][0]!== "w"){
              discard.unshift(discard[0][0].concat('-'));
              check =999;
            }
            index=nextPlayer;
            if(deck.length >0){
            for(var i =0; i<wild*4;i++){
              hands[nextPlayer].push(deck[0]);
              deck.splice(0,1);
              }
            }
           nextIndex();
          }
        }
      }




      function drawCard(position){
        //index =2
        discard.unshift(hands[index][position]);
        hands[index].splice(position,1);
        var count =1;
        if(index<hands.length && index>=0 ){
        var nextPlayer = 0;
        if(reverse%2 == 0){
          nextPlayer = index+1;
          if(nextPlayer == hands.length){nextPlayer=0;}
        }
        if(reverse%2 !==0){
          nextPlayer = index-1;
          if(nextPlayer == -1){nextPlayer=hands.length-1;}
        }
        var i=0;
        for (i=0;i<hands[nextPlayer].length;i++){
          if(hands[nextPlayer][i][0] !== "w" && hands[nextPlayer][i][1] == "d" ) {
            discard.unshift(hands[nextPlayer][i]);
            hands[nextPlayer].splice(i,1);
            count++;
            index=nextPlayer;
              if(reverse%2 == 0){
                nextPlayer++;
                if(nextPlayer == hands.length){nextPlayer=0;}
              }
              if(reverse%2 !== 0){
                nextPlayer--;
                if(nextPlayer == -1){nextPlayer=hands.length-1;}
              }
              i=-1;
            }    
          } 
         }
         index=nextPlayer;
         if(index == hands.length){index=0;}
         if(index == -1){index=hand.length-1;}
          /*do you need nextPlayer ++ for some cases
            some cases play one more move*/
          discard.unshift(discard[0][0].concat('-'));
         if(hands[index].length>0){
          if(deck.length>0){
          for(var j =0;j<count*2;j++){
            hands[index].push(deck[0]);
            deck.splice(0,1);
        }
      }

    }
    nextIndex();
    check = 999;
  }

  if(index>=0 && index<hands.length){
      if(check === 0){
        check =1;
      for(var i=0; i<hands[index].length;i++){
        if(hands[index][i][0] == discard[0][0] && hands[index][i][1] == "r" ){
          discard.unshift(hands[index][i]);
          hands[index].splice(i,1);
          reverse++;
          nextIndex();
          check=999;
          break;
          }
        if (hands[index][i][0] == discard[0][0] && hands[index][i][1] == "s"){
          check =999;
          discard.unshift(hands[index][i]);
          hands[index].splice(i,1);
          nextIndex();
          nextIndex();
          break;
          }
        if (hands[index][i][0] == discard[0][0] && hands[index][i][1] == "d"){
          check =999;
          drawCard(i);
          break;
          }
        if(discard[0][0] == hands[index][i][0] && hands[index][i][1] !=="d"){
          discard.unshift(hands[index][i]);
          hands[index].splice(i,1);
          check = 999;
          nextIndex();
          break;
          }   
        }
      }
      //W4
      if(check === 1) {
        check = 2;
        for(var i=0;i<hands[index].length;i++){
          if(hands[index][i][0] == "w" && hands[index][i][1] == "d") {
            discard.unshift(hands[index][i]);
            hands[index].splice(i,1);
            if(hands[index][0][0] !== "w"){
              discard.unshift(hands[index][0][0].concat('-'));
            }
            if(hands[index][0][0] == "w"){
              for(var j=0; j<hands[index].length;j++){
                if(hands[index][j][0]!== "w"){
                discard.unshift(hands[index][j][0].concat("-"));
                break;
                }
              }
            }
            wild4();
            check =999;
            }
         }
      }
      //MATCH ##
      if (check === 2){
        check=3;
        for(var i=0; i<hands[index].length;i++){
          if(discard[0][1] == "r" && hands[index][i][1] == discard[0][1]){
            discard.unshift(hands[index][i]);
            hands[index].splice(i,1);
            reverse++;
            check=999;
            nextIndex();
            break;
            }
        if(discard[0][1]== hands[index][i][1] && discard[0][1]=="s"){
          discard.unshift(hands[index][i]);
          hands[index].splice(i,1);
          nextIndex();
          nextIndex();
          check=999;
          break;
        }
        if(discard[0][1] == hands[index][i][1] && discard[0][1] !== "-"){
          discard.unshift(hands[index][i]);
          hands[index].splice(i,1);
          check = 999;
          nextIndex();
          break;
          }  
        }
      }
      //MATCH WILD-
      if(check === 3){
        check =4;
        for(var i=0;i<hands[index].length;i++){
          if((hands[index][i][0] == "w" && hands[index][i][1] == "-") ) {
            discard.unshift(hands[index][i]);
            hands[index].splice(i,1);
            if(hands[index].length>0){
              if(hands[index][0][0] !=="w"){
                discard.unshift(hands[index][0][0].concat('-'));
              }
              if(hands[index][0][0] == "w"){
                for(var i=0; i<hands[index].length;i++){
                  if(hands[index][i][0] !=="w"){
                    discard.unshift(hands[index][i][0].concat('-'));
                    break;
                  }
                }
              }
            }
            check =999;
            nextIndex();
            break;
            }
         }
      }
      //draw from deck
      if(check === 4){
        if(deck.length>0){
          hands[index].push(deck[0]);
          deck.splice(0,1);
          nextIndex();
        }
        else{
          temp=false;
        }
       }
       for(var j =0;j<hands.length;j++){
         if(hands[j].length ==0){
           discard.unshift("--");
           temp=false;
         }
       }

      
    }
  }

return { deck:deck , discard:discard , hands:hands };
  }

  return whatever;
}
