module MaybeT where

import Data.Monoid ((<>))
import Control.Monad.Trans.Class
import Control.Monad.Trans.Maybe

fromMaybe :: Monad m => Maybe a -> MaybeT m a
fromMaybe = MaybeT . return

-- say we have a Maybe String
maybeString :: Maybe String
maybeString = Just "value"

-- and we have some effect, that does not return any meaningful value
effectOnly :: IO ()
effectOnly = putStrLn "1. effect only, will return nothing"

-- and we also have another effectful function, returning a value
effectAndGetValue :: String -> IO String
effectAndGetValue a = (putStrLn "2. another effect!") >> (pure $ "that " <> a)

main :: IO ()
main = (runMaybeT $ do
  _    <- lift effectOnly                           -- MaybeT IO ()     unpacks to ()
  val1 <- fromMaybe maybeString                     -- MaybeT IO String unpacks to String
  val2 <- lift $ effectAndGetValue val1             -- MaybeT IO String unpacks to String
  _    <- lift $ putStrLn $ "3. printing: " <> val2 -- MaybeT IO ()     unpacks to ()
  return ()) >> pure ()                             -- runMaybeT results in IO (Maybe ()), so we need to map it to IO ()
