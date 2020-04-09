import System.IO (stdout, hFlush)
import Data.List (intercalate)

-- | implementation of the question function in haskell
question :: String -> [String] -> IO String
question prompt [] = do
    putStrLn prompt
    putStr ": "
    hFlush stdout
    getLine
question prompt valid = do
    putStrLn prompt
    putStr $ "(" ++ intercalate ", " valid ++ "): "
    hFlush stdout
    input <- getLine
    if input `elem` valid then return input
    else do
        putStrLn $ "\"" ++ input ++ "\" is not a valid answer!"
        question prompt valid

main = question "foo" ["bar", "baz"]
