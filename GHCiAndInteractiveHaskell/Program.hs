-- :!command - Allows us to execute bash command
-- :type x - Shows x type
-- it - last execution result
-- :kind - the kind od the supertype ex: :kind Num
-- :info - returns the type + where is located in the code
-- :load Program - Compiles program
-- :main - executes the main
-- :run main - executes the parameter
-- :edit - without argument opens the last code loaded into an editos, need to :set editor
-- :reload - reloads the last module
-- :browse Main - shows all methods in Main module

module Main (main, prettyPrint) where

type Port = Int

data Address = Address Int Int Int Int Port

prettyPrint :: Address -> IO()
prettyPrint (Address ip0 ip1 ip2 ip3 port)
    = putStrLn $
        show ip0 ++ "." ++
        show ip1 ++ "." ++
        show ip2 ++ "." ++
        show ip3 ++ ":" ++ show port

main ::IO()
main = prettyPrint (Address 127 0 0 1 80)