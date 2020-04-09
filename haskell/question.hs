import System.IO (stdout, hFlush)

-- | implementation of the question function in haskell
question :: String -> [String] -> IO String
question prompt valid = do
    putStrLn prompt
    if length valid /= 0 then
        putStr $ "(" ++ ((map (\x -> if x /= last valid then x ++ ", " else x) valid) >>= id) ++ "): "
    else putStr ": "
    hFlush stdout
    input <- getLine
    if length valid == 0 || input `elem` valid then return input
    else do
        putStrLn $ "\"" ++ input ++ "\" is not a valid answer!"
        question prompt valid

main = question "foo" ["bar", "baz"]
