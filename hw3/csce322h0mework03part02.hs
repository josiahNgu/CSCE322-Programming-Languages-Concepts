import Prelude
import System.Environment ( getArgs )
import Data.List
import Helpers

-- The main method that will be used for testing / comgand line access
main = do
     args <- getArgs
     filename <- readFile (head args)
     (hands,deck,discard) <- readUnoFile filename
     print "Result"
     let (ha,de,di) = onePlayerManyMoves discard deck (head hands)
     printGame ([ha],de,di)

-- YOUR CODE SHOULD COME AFTER THIS POINT
onePlayerManyMoves :: [(Char,Char)] -> [(Char,Char)]->[(Char,Char)] -> ([(Char,Char)],[(Char,Char)],[(Char,Char)])
onePlayerManyMoves _ [] _ = ([],[],[])
onePlayerManyMoves di de ha = manyMoves ha de di 

manyMoves:: [(Char,Char)]->[(Char,Char)]->[(Char,Char)] -> ([(Char,Char)],[(Char,Char)],[(Char,Char)])
manyMoves ha de di
          | length ha == 0 = (ha,de,[('-','-')]++di)
          | length de == 0 && haveColor ha di /=1 && haveWild4 ha /=1 && haveWild ha /=1 && haveSymbol ha di /=1 = (ha,de,di)
        --   | length de ==0 && haveColorDraw ha ==1 = (color ha di) (de) (++di) --fix to stop game on draw when deck length ==0
          | length di >2 && tailDifst == 'w' && tailDisnd =='d' && haveWild4 ha /=1 = manyMoves (drawDeck ha de ((countWDs di)*4)) (removeDeck de ((countWDs di)*4)) (addToDiscard ha di ha 1) 
          | length di >2 && tailDifst == 'w' && tailDisnd =='d' && haveWild4 ha ==1 = manyMoves (wild4 ha) (de) (addToDiscard ha di ha 5) 
          | fst(head di ) /='w' && snd(head di) =='d' && haveColorDraw ha ==1 = manyMoves (draw2 ha) (de) (addToDiscard ha di ha 2)
          | fst(head di) /='w' && snd(head di) =='d' && haveColorDraw ha /=1 = manyMoves (drawDeck ha de ((countCDs di)*2)) (removeDeck de ((countCDs di)*2)) (addToDiscard ha di ha 3)
          | haveColor ha di == 1 = manyMoves (color ha di) (de) (addToDiscard ha di ha 4)
          | length de >0 && haveWild4 ha == 1 = manyMoves (wild4 ha) (de) (addToDiscard ha di ha 5)
          | length de == 0  && haveWild4 ha ==1 = (wild4 ha,de,[(fst(head ha),'-')]++[('w','d')]++di)
          | haveSymbol ha di == 1 = manyMoves (symbol ha di) (de) (addToDiscard ha di ha 6)
          | haveWild ha == 1 = manyMoves (wild ha) (de) (addToDiscard ha di ha 7)
          | (length de) >0 = manyMoves (drawDeck ha de 1) (removeDeck (de) 1) (di)
          | otherwise = (ha,de,di)
          where 
            tailDisnd = snd(head(tail di))
            tailDifst = fst(head(tail di))

haveColor ::  [(Char,Char)] -> [(Char,Char)] -> Int
haveColor [] _ = 0
haveColor (h:t) di 
          | (fst h) == fst (head di) = 1
          | otherwise = haveColor t di

haveColorDraw :: [(Char,Char)] -> Int
haveColorDraw [] =0
haveColorDraw (h:t) 
              | (fst h) /= 'w' && (snd h) == 'd' = 1
              | otherwise = haveColorDraw t

haveSymbol:: [(Char,Char)] -> [(Char,Char)] -> Int
haveSymbol [] _ = 0
haveSymbol (h:t) di 
          | (snd h) == snd (head di) && (snd h) /= '-' = 1
          | otherwise = haveSymbol t di

haveWild4 :: [(Char,Char)] -> Int
haveWild4 [] = 0
haveWild4 (h:t) 
          | (fst h) == 'w' && (snd h) == 'd' = 1
          | otherwise = haveWild4 t

haveWild :: [(Char,Char)] -> Int
haveWild [] = 0
haveWild (h:t) 
          | (fst h) == 'w' && (snd h) == '-' = 1
          | otherwise = haveWild t

-- need to pass in an int and list 
remove :: [(Char,Char)]->Int ->[(Char,Char)]
remove [] _ = []
remove (h:t) ind
      | ind ==0  = t 
      | ind >= length (h:t)|| ind< 0 = h:t
      |otherwise  = h:(remove t (ind-1))
      
color:: [(Char,Char)] ->[(Char,Char)] -> [(Char,Char)] 
color [] _ = []
color (h:t) di 
      | headDiscard /= 'w' && headDiscard == fst(h) = removeHands 
      | otherwise = h:(color t di)
      where headDiscard =fst (head di)
            removeHands = remove (h:t) 0 

draw2:: [(Char,Char)] -> [(Char,Char)] 
draw2 [] = []
draw2 (h:t)
      | fst (h) /= 'w' && snd (h) == 'd' = remove (h:t) 0
      | otherwise = h:(draw2 t)

wild4 :: [(Char,Char)]  -> [(Char,Char)] 
wild4[] = []
wild4 (h:t)
      | fst (h) == 'w' && snd(h) == 'd' = remove (h:t) 0 
      | otherwise = h:(wild4 t)


wild :: [(Char,Char)]  -> [(Char,Char)] 
wild []  = []
wild (h:t) 
    | fst (h) == 'w' && snd(h) == '-' = remove (h:t) 0
    | otherwise = h:(wild t)

symbol:: [(Char,Char)] ->[(Char,Char)] -> [(Char,Char)] 
symbol [] _ = []
symbol (h:t) di 
      | headDiscard /= 'w' && sndDiscard == snd(h) && snd(h)/='-' = remove (h:t) 0
      | otherwise = h:(symbol t di )
      where headDiscard =fst (head di)
            sndDiscard = snd (head di)
--1 5 
addToDiscard :: [(Char,Char)]-> [(Char,Char)] -> [(Char,Char)] ->Int -> [(Char,Char)] 
addToDiscard _ [] _ _ = []
addToDiscard [] _ _ _ = []
addToDiscard (h:t) di ha number 
            | number ==1 && length di >2 && fst(head(tail di)) == 'w' && snd(head(tail di)) == 'd' = [(fst(head di),'-')]++di
            | number ==2 && fst(head di) /= 'w' && snd(head di) == 'd' && fst (h) /= 'w' && snd (h) =='d' = h:di
            | number ==3 &&fst(head di) /= 'w' && snd(head di) == 'd' = [(fst(head di),'-')]++di
            | number ==4 && haveColor ([h]) di == 1 && headDiscard == fst(h)= h:di 
            | number ==5 && fst(head ha) =='w' = [(pickColor ha,'-')]++[('w','d')]++di
            | number ==5 = [(fst(head ha),'-')]++[('w','d')]++di
            | number ==6 && haveSymbol ([h]) di == 1 && snd(h) == snd(head di) = h:di
            | number ==7  && fst (h) == 'w' && snd (h) == '-' && length ha ==1 = [(fst(h),'-')]++di
            | number ==7 && fst (h) == 'w' && snd (h) == '-' && fst(head ha) /='w' = [(fst(head ha),'-')]++[(fst(h),'-')]++di
            | number ==7 && fst (h) == 'w' && snd (h) == '-' && fst(head ha) =='w' =[(pickColor ha,'-')]++[(fst(h),'-')]++di
            | otherwise = addToDiscard t di ha number
                where headDiscard = fst (head di)

countCDs:: [(Char,Char)] -> Int
countCDs []  = 0
countCDs [_]= 0
countCDs (h:t) 
  | cd == ('d') = 1 +(countCDs (t))
  | otherwise	 = 0
  where cd = snd(h)

countWDs :: [(Char,Char)] -> Int
countWDs [] = 0
countWDs [_]= 0
countWDs (h:t)
    | wd == ('w','d') = 1 + (countWDs (tail t))
    | otherwise	   = 0
    where wd = (head t)

drawDeck::[(Char,Char)]->[(Char,Char)] ->Int ->[(Char,Char)] 
drawDeck ha de count
        | count > 0  && length de >0 = (drawDeck (ha++[(head de)]) (tail de) (count-1) )
        | otherwise = ha

removeDeck:: [(Char,Char)]->Int->[(Char,Char)] 
removeDeck [] _ = []
removeDeck (h:t) count
            | count >0 && length (h:t) > 0 = (removeDeck t (count-1))
            | otherwise = (h:t)

pickColor :: [(Char,Char)] -> Char
pickColor hand 
    | (length nonWs) == 0 = 'r'
    | otherwise	= ourFirst (head nonWs)
    where nonWs = [(c,s) | (c,s) <- hand , c /= 'w']

ourFirst :: (a,b) -> a
ourFirst (a,b) = a
