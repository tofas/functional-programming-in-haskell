data Colour = RGB Int Int Int deriving Show

red :: Colour -> Int
red = \(RGB r _ _) -> r

main :: IO()
main = do
    let c = RGB 10 20 30
    print $ red c