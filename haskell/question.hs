import System.IO (stdout, hFlush)

-- | implementation of the question function in haskell
question :: String -> [String] -> IO String
question prompt [] = do
    putStrLn prompt
    putStr ": "
    hFlush stdout
    getLine
question prompt valid = do
    putStrLn prompt
    putStr $ "(" ++ ((map (\x -> if x /= last valid then x ++ ", " else x) valid) >>= id) ++ "): "
    hFlush stdout
    input <- getLine
    if input `elem` valid then return input
    else do
        putStrLn $ "\"" ++ input ++ "\" is not a valid answer!"
        question prompt valid

main = question "foo" ["bar", "baz"]
