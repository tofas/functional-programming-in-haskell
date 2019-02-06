module Main(main) where

-- File watcher: stack build --fast --file-watch --exec todo-list

import Options.Applicative

type ItemIndex = Int

defaultDataPath :: FilePath
defaultDataPath = "~/stack.yaml"

dataPathParser :: Parser FilePath
dataPathParser = strOption $
    value defaultDataPath
    <> long "data-path"
    <> short 'p'
    <> metavar "DATAPATH"
    <> help ("path to data file (default " ++ defaultDataPath ++ ")")

itemIndexParser :: Parser ItemIndex
itemIndexParser = argument auto (metavar "ITEMINDEX" <> help "index of item")

main :: IO()
main = do
    dataPath <- execParser (info (dataPathParser) (progDesc "Todo-list manager"))
    putStrLn $ "dataPath=" ++ show dataPath

    --itemIndex <- execParser (info (itemIndexParser) (progDesc "To-do list manager"))
    --putStrLn $ "itemIndex=" ++ show itemIndex