module Main
import TBoolean

writeBoolean : TBoolean -> IO ()
writeBoolean b = putStrLn (toString b)

writeString : String -> IO ()
writeString = putStrLn

emptyLine : IO ()
emptyLine = writeString ""

main : IO ()
main = do
    emptyLine
    writeString "NOT"
    writeBoolean (not TTrue)
    writeBoolean (not TFalse)
    emptyLine
    writeString "ORs"
    writeBoolean (TTrue `or` TTrue)
    writeBoolean (TTrue `or` TFalse)
    writeBoolean (TFalse `or` TTrue)
    writeBoolean (TFalse `or` TFalse)
    emptyLine
    writeString "ANDs"
    writeBoolean (TTrue `and` TTrue)
    writeBoolean (TTrue `and` TFalse)
    writeBoolean (TFalse `and` TTrue)
    writeBoolean (TFalse `and` TFalse)
