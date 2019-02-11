module Main(main) where

-- File watcher: stack build --fast --file-watch --exec todo-list

-- Options.Applicative already have an info parser, in order to 
-- use the one defined here we must use hiding method
import Options.Applicative hiding (infoParser)

type ItemIndex = Int
type ItemTitle = String
type ItemDescription = Maybe String
type ItemPriority = Maybe String
type ItemDueBy = Maybe String

data ItemUpdate = ItemUpdate
    { titleUpdate :: Maybe ItemTitle
    , descriptionUpdate :: Maybe ItemDescription
    , priorityUpdate :: Maybe ItemPriority
    , dueByUpdate :: Maybe ItemDueBy
    } deriving Show

data Options FilePath Command deriving Show
data Command = 
    Info
    | Init
    | List
    | Add
    | View
    | Update ItemIndex ItemUpdate
    | Remove
    deriving Show

defaultDataPath :: FilePath
defaultDataPath = "~/stack.yaml"

infoParser :: Parser Command
infoParser = pure Info

initParser :: Parser Command
initParser = pure Init

listParser :: Parser Command
listParser = pure List

addParser :: Parser Command
addParser = pure Add

viewParser :: Parser Command
viewParser = pure View

updateParser :: Parser Command
updateParser = Update <$> itemIndexParser <*> updateItemDescriptionParser

updateItemParser :: Parser ItemUpdate
updateItemParser = ItemUpdate
    <$> optional updateItemTitleParser 
    <*> optional updateItemDescriptionParser
    <*> optional updateItemPriorityParser
    <*> optional updateItemDueByParser

updateItemTitleParser :: Parser ItemTitle
updateItemTitleParser = itemTitleValueParser

removeParser :: Parser Command
removeParser = pure Remove

commandParser :: Parser Command
commandParser = subparser $ mconcat 
    [ command "info" (info infoParser (progDesc "Show info"))
    , command "init" (info initParser (progDesc "Initialize items"))
    , command "list" (info listParser (progDesc "List all items"))
    , command "add" (info addParser (progDesc "Add item"))
    , command "view" (info viewParser (progDesc "View item"))
    , command "update" (info updateParser (progDesc "Update item"))
    , command "remove" (info removeParser (progDesc "Remove item"))]

-- <$> = fmap
-- <*> = Applied over
optionsParser :: Parser Options
optionsParser = Options
    <$> dataPathParser
    <*> commandParser

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
    Options dataPath command <- execParser (info (optionsParser) (progDesc "Todo-list manager"))
    run dataPath command
    -- options <- execParser (info (optionsParser) (progDesc "Todo-list manager"))
    -- putStrLn $ "options=" ++ show options

    --itemIndex <- execParser (info (itemIndexParser) (progDesc "To-do list manager"))
    --putStrLn $ "itemIndex=" ++ show itemIndex

run :: FilePath -> Command -> IO()
run dataPath Info = putStrLn "Info"
run dataPath Init = putStrLn "Init"
run dataPath List = putStrLn "List"
run dataPath Add = putStrLn "Add"
run dataPath View = putStrLn "View"
run dataPath (Update idx itemUpdate) = putStrLn $ "Update: idx= " ++ show idx ++ " itemUpdate=" ++ show itemUpdate 
run dataPath Remove = putStrLn "Remove"
