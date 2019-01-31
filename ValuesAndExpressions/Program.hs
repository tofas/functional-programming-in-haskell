-- intercalate - concatenates the elements of a list with a separator

-- formatList "(" ")" ", " [1,2,3,4]
formatList start end separator xs = start ++ (intercalate separator (map show xs)) ++ end

f = let s = "Hello World" in putStrLn $ "(" ++ s ++ ")"

doubleIt x = x * 2
addTen x = x + 10

addTen (doubleIt 5)
-- composition, equivalent to upper expression
(addTen . doubleIt) 5

-- lambdas
\x -> x + 10

-- ghci
-- :{ - start multiline expression in command line
-- :} - finish multiline exression in command line

parenthesizeWords s = unwords $ map parenthesizeWord (word s)
    where parenthesizeWord s = "(" ++ s ++ ")"

parenthesizeWords s = unwords $ map (\s -> "(" ++ s ++ ")") (word s)


filter (\x -> x < 5) [1..10]
-- as < is a binary operator we can express it without the left variable as (< 5) and
-- will evaluate
filter (< 5) [1..10]
