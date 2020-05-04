{-# LANGUAGE FlexibleInstances #-}
-- try disabling the pragma above and see the compiler complain

class TooMany a where
  tooMany :: a -> Bool

instance TooMany Int where
  tooMany n = n > 42

instance TooMany (Int, String) where
  tooMany (n, _) = n > 42
