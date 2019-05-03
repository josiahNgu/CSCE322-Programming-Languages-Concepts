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
     let (ha,de,di) = onePlayerOneMove discard deck (head hands)
     printGame ([ha],de,di)

-- YOUR CODE SHOULD COME AFTER THIS POINT
-- w4, color, wild , draw2, drawfrom deck
-- let t =[('r','9') ,('y','d') ,('w','-') ,('w','d') ,('r','s') ,('r','r') ,('g','d')]
-- let d = [('r','6')]
onePlayerOneMove :: [(Char,Char)] -> [(Char,Char)] -> [(Char,Char)] -> ([(Char,Char)],[(Char,Char)],[(Char,Char)])
onePlayerOneMove di de ha = oneMove di de ha 

oneMove :: [(Char,Char)] -> [(Char,Char)] -> [(Char,Char)]-> ([(Char,Char)],[(Char,Char)],[(Char,Char)])
oneMove _ _ []  = ([],[],[])
oneMove di de ha 
      | (haveColor ha di) == 1 = ( (color ha di) ,(de), (addToDiscard ha di ha)) 
      | haveWild4 ha == 1 = ((wild4 ha) ,(de), (addToDiscard ha di ha ))
      | (haveSymbol ha di) == 1 = ((symbol ha di),(de),addToDiscard ha di ha)
      | haveWild ha == 1 = ((wild ha) ,(de),(addToDiscard ha di ha))
      | otherwise = ((drawDeck ha de) ,(removeDeck de), di)

haveColor ::  [(Char,Char)] -> [(Char,Char)] -> Int
haveColor [] _ = 0
haveColor (h:t) di 
         | (fst h) == fst (head di) = 1
         | otherwise = haveColor t di

haveSymbol [] _ = 0
haveSymbol (h:t) di 
         | (snd h) == snd (head di) = 1
         | otherwise = haveSymbol t di

haveWild4 :: [(Char,Char)] -> Int
haveWild4 []  = 0
haveWild4 (h:t) 
          | (fst h) == 'w' && (snd h) == 'd' = 1
          | otherwise = haveWild4 t

haveWild :: [(Char,Char)] -> Int
haveWild []  = 0
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

wild4 :: [(Char,Char)]  -> [(Char,Char)] 
wild4[] = []
wild4 (h:t)
      | fst (h) == 'w' && snd(h) == 'd' = remove (h:t) 0 
      | otherwise = h:(wild4 t)


wild :: [(Char,Char)]  -> [(Char,Char)] 
wild[]  = []
wild (h:t) 
   | fst (h) == 'w' && snd(h) == '-' = remove (h:t) 0
   | otherwise = h:(wild t)

symbol:: [(Char,Char)] ->[(Char,Char)] -> [(Char,Char)] 
symbol [] _ = []
symbol (h:t) di 
      | headDiscard /= 'w' && sndDiscard == snd(h) = remove (h:t) 0
      | otherwise = h:(symbol t di )
      where headDiscard =fst (head di)
            sndDiscard = snd (head di)

addToDiscard :: [(Char,Char)]-> [(Char,Char)] -> [(Char,Char)] -> [(Char,Char)] 
addToDiscard _ [] _  = []
addToDiscard (h:t) di ha
            | haveColor (h:t) di == 1 && headDiscard == fst(h)= h:di 
            | haveColor (h:t) di /= 1  && haveWild4 (h:t)  == 1 && fst (h) == 'w' && snd (h) == 'd' = [(fst(head ha),'-')]++[h]++di
            | haveColor (h:t) di /=1 && haveWild4 (h:t) /= 1 && haveSymbol (h:t) di == 1 && snd(h) == snd(head di) = h:di
            | haveColor (h:t) di /= 1 && haveWild4 (h:t) /= 1 && haveSymbol (h:t) di /=1 && fst (h) == 'w' && snd (h) == '-' = [(fst(head ha),'-')]++[(fst( h),'-')]++di
            | otherwise = addToDiscard t di ha
               where headDiscard = fst (head di)

removeDeck:: [(Char,Char)]  ->[(Char,Char)] 
removeDeck (h:t) = (t )
 
drawDeck::  [(Char,Char)]  ->[(Char,Char)] ->[(Char,Char)] 
drawDeck ha de = ha++[(head de)]
