import Control.Monad.Except
import Control.Monad

logic :: (Monad m, MonadError e m) => Int -> e -> m Int
logic n e = if n `mod` 2 == 0
  then return $ n * 1000
  else throwError e

-- we're declaring (using constraints before the fat arrow) that both left and right values will need to be "printable"
liftEither :: (Show l, Show r) => Either l r -> IO ()
liftEither (Right a) = putStrLn $ "it worked: " ++ (show a)
liftEither (Left e)  = putStrLn $ "it failed with error: " ++ (show e)

main :: IO ()
main = let
  result = do  -- try changing the arguments below, to eg odd numbers and see how the error is raised and the steps are short-circuited
  a <- logic 5 "goddamit, it failed on the first step!" :: Either String Int -- this "type assertion" notation is like calling `logic[Either[String, Int]]` in Scala
  b <- logic 4 "goddamit, it failed on the second step!"
  return $ a + b  -- "return $ a + b" is like "yield a + b" in Scala
  in liftEither result
