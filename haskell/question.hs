question prompt valid = do
    let joined = unwords valid ++ ":"
    putStrLn prompt
    putStrLn joined
    resp <- getLine
    if resp `elem` valid then return resp 
    else do 
        putStrLn("Please enter a valid input!")
        question prompt valid

main = do
    inp <- question "Foo" ["Bar", "Baz"]
    putStrLn $ "You answered " ++ inp
