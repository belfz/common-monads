import Control.Monad.Reader

newtype ConnectionString = ConnectionString { val :: String }

data Config = Config { host :: String, port :: Int }

getHost :: Reader Config String
getHost = do
  config <- ask
  return (host config)

getPort :: Reader Config Int
getPort = do
  config <- ask
  return (port config)

getConnectionString :: Reader Config ConnectionString
getConnectionString = do
  host <- getHost
  port <- getPort
  return $ ConnectionString (host ++ ":" ++ (show port))

-- use Reader to implicitly pass the configuration around and extract/transform values
main :: IO ()
main = let
  config = Config "localhost" 8080
  in putStrLn $ val (runReader getConnectionString config)
  --                  \_ runReader    \_ Reader   \_ environment
