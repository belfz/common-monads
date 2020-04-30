{-# LANGUAGE OverloadedStrings #-}

-- "import qualified .. as": expose the package under namespace alias ("as T" in this case) and always
-- require the namespace prefix (eg. T.Text, T.putStrLn instead of Text, putStrLn)
import qualified Data.Text as T
import qualified Data.Text.IO as T
import Data.Monoid ((<>))

greeting :: T.Text
-- greeting = pack "hello" -- without "OverloadedStrings" we'd have to `pack` and `unpack` Strings to/from Text
greeting = "hello"

main :: IO ()
main = do
  T.putStrLn greeting
  let len = T.length greeting
  T.putStrLn $ "the length of the greeting above is " <> (T.pack . show $ len)
