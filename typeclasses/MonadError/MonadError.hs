import Control.Monad.Except
-- import Data.Either

logic :: MonadError e m => Int -> e -> m Int
logic n e = if n `mod` 2 == 0
  then return $ n * 1000
  else throwError e

main :: IO ()
main = let
  result = do  -- try changing the arguments below, to eg odd numbers and see how the error is raised and the steps are short-circuited
  a <- logic 2 "goddamit, it failed on the first step!" :: Either String Int -- this "type assertion" notation is like calling `logic[Either[String, Int]]` in Scala
  b <- logic 4 "goddamit, it failed on the second step!"
  return $ a + b  -- "return $ a + b" is like "yield a + b" in Scala
  in either (\l -> putStrLn $ "it failed with error: " ++ (show l)) (\r -> putStrLn $ "it worked: " ++ (show r)) result
