import Test.Hspec
import Test.QuickCheck
import Diamond
import Data.List (transpose)

main = hspec $ do
    describe "a diamond" $ do
        let d = forAll $ fmap diamond $ choose ('A','Z')

        it "has its height equal to its width" $ 
            d $ \d -> length d == length (transpose d)

        it "is reversible vertically" $ 
            d $ \d -> d == reverse d

        it "is reversible horizontally" $ 
            d $ \d -> d == map reverse d

        it "contains letters in order in each quarter" $ do
            d $ \d -> let  size d     = 1+length d `div` 2 
                           letters d  = take (size d) ['A'..'Z'] 
                           pattern      = map (head . dropWhile (==' '))
                           firstHalf  d = take (size d) d 
                           secondHalf d = drop (pred (size d)) d 
                    in and [pattern (firstHalf d) == letters d
                           ,pattern (secondHalf d) == reverse (letters d)
                           ,pattern (firstHalf (transpose d)) == reverse (letters d)
                           ,pattern (secondHalf (transpose d)) == letters d]
