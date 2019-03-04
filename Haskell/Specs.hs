import Test.Hspec
import Test.QuickCheck
import Diamond
import Data.List (transpose)
import Control.Arrow

main = hspec $ do
    describe "a diamond" $ do
        let d = forAll $ fmap diamond $ choose ('A','Z')
            equ f g = uncurry (==) . (f &&& g)
            allTrue props = and . zipWith ($) props . repeat

        it "has its height equal to its width" $ 
            d $ (length `equ` (length . transpose)) 

        it "is reversible vertically" $ 
            d $ (id `equ` reverse)

        it "is reversible horizontally" $ 
            d $ (id `equ` map reverse)

        it "contains letters in order in each quarter" $ do
            d $  let  size       = succ . (`div` 2) .  length 
                      letters    = flip take ['A'..'Z'] . size 
                      firstNonSp = head . dropWhile (==' ')
                      nonSp      = map firstNonSp
                      firstHalf  d = take (size d) d 
                      secondHalf d = drop (pred (size d)) d 
                      in allTrue [(nonSp . firstHalf) `equ` letters
                                 ,(nonSp . secondHalf) `equ` (reverse . letters)
                                 ,(nonSp . firstHalf . transpose) `equ` (reverse . letters)
                                 ,(nonSp . secondHalf . transpose) `equ` letters]
