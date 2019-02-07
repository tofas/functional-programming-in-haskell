module Main(main) where

-- File watcher: stack build --fast --file-watch --exec todo-list

import Options.Applicative

type ItemIndex = Int
type ItemDescription = Maybe String

data Options FilePath ItemIndex ItemDescription deriving Show

defaultDataPath :: FilePath
defaultDataPath = "~/stack.yaml"

-- <$> = fmap
-- <*> = Applied over
optionsParser :: Parser Options
optionsParser = Options
    <$> dataPathParser
    <*> itemIndexParser
    <*> updateItemDescriptionParser

dataPathParser :: Parser FilePath
dataPathParser = strOption $
    value defaultDataPath
    <> long "data-path"
    <> short 'p'
    <> metavar "DATAPATH"
    <> help ("path to data file (default " ++ defaultDataPath ++ ")")

itemIndexParser :: Parser ItemIndex
itemIndexParser = argument auto (metavar "ITEMINDEX" <> help "index of item")

itemDescriptionValueParser :: Parser String
itemDescriptionValueParser = 
    strOption (long "desc" <> short "d" <> metavar "DESCRIPTION" <> help "description")

-- <|> = Or
updateItemDescriptionParser :: Parser ItemDescription
updateItemDescriptionParser = 
    Just <$> itemDescriptionValueParser
    <|> flag' Nothing (long "clear-desc")

main :: IO()
main = do
    options <- execParser (info (optionsParser) (progDesc "Todo-list manager"))
    putStrLn $ "options=" ++ show options

    --itemIndex <- execParser (info (itemIndexParser) (progDesc "To-do list manager"))
    --putStrLn $ "itemIndex=" ++ show itemIndex