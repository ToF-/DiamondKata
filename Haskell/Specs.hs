import Test.Hspec
import Test.QuickCheck
import Diamond

main = hspec $ do
    describe "a diamond" $ do
        let letter = forAll $ choose ('A','Z')
        it "contains letters from A to given letter" $ 
            letter $ \c -> and (zipWith elem ['A'..c](diamond c))
            
        it "contains no other letters than A to given letter or space" $ 
            letter $ \c -> all (`elem` ' ':['A'..c]) (concat (diamond c))

        it "is reversible horizontally" $ 
            letter $ \c -> diamond c == reverse (diamond c)

        it "is reversible vertically" $ 
            letter $ \c -> diamond c == map reverse (diamond c)

        it "has height equals to number of letters times 2 minus 1" $ 
            letter $ \c -> length (diamond c) == (length ['A'..c] * 2 - 1) 

        it "has width equals to number of letters times 2 minus 1" $ 
            letter $ \c -> all (== (length ['A'..c] * 2 - 1)) (map length (diamond c))

