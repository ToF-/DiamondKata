module Diamond
where

diamond :: Char -> [String]
diamond letter = 
    let 
        range a b = takeWhile (<= b) (iterate succ a)
        letters   = range 'A' letter
        spaces    = map (flip replicate ' ') (range 0 (length letters - 1))
        (<>)       = zipWith (++)    
        (>>)       = zipWith (:)
        diagonal  = (reverse  spaces) <> (letters >> spaces)
        mirror l  =  l ++ tail (reverse l) 
    in  mirror (map mirror diagonal)
