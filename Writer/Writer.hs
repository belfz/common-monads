import Control.Monad.Writer.Strict
import Data.Monoid

type RunningResult = Writer String Int

logic :: RunningResult -> RunningResult
logic init = do
  _ <- tell "initiating calculations; "
  a <- init
  b <- writer (32, "adding 32; ")
  _ <- tell "done."
  return $ a + b

printAll :: (Show a, Show w) => (a, w) -> IO ()
printAll (res, w) = let
  resultLine = "the result is: " ++ (show res)
  logLine    = "the log is: " ++ (show w)
  in putStrLn resultLine >> putStrLn logLine

main :: IO ()
main = let
  init = writer (10, "") :: RunningResult
  in printAll $ runWriter $ logic init
