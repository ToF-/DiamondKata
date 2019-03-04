import Test.Hspec
import Test.QuickCheck
import Diamond
import Data.List (transpose)

main = hspec $ do
    describe "a diamond" $ do
        let diam = forAll $ fmap diamond $ choose ('A','Z')

        it "has its height equal to its width" $ 
            diam $ \d -> length d == length (transpose d) 

        it "is reversible vertically" $ 
            diam $ \d -> reverse d == d

        it "is reversible horizontally" $ 
            diam $ \d -> map reverse d == d

        it "contains letters in order in each quarter" $ do
            diam $ \d -> let s  = length d `div` 2 + 1 
                             ls = take s ['A'..'Z'] 
                             ns = map (head . dropWhile (==' '))
                             d' = transpose d
                             fh = take s
                             sh = drop (s-1)
                         in ns (fh d) == ls 
                         && ns (sh d) == reverse ls
                         && ns (fh d') == reverse ls
                         && ns (sh d') == ls
