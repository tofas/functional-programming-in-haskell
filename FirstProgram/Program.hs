-- print the string to the terminal no side effect
main :: IO()
main = do
    content <- readFile "numbers.txt"
    putStrLn content