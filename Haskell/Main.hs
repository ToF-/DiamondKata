import System.Environment
import Diamond

main = do
    max <- fmap (head . head) getArgs
    putStr $ unlines $ diamond max
