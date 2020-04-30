{-# LANGUAGE GADTs #-}

data GenericBox a where
  HoldsInt  :: Int -> GenericBox a
  HoldsBool :: Bool -> GenericBox a
  HoldsOrd  :: Ord a => a -> GenericBox a
  HoldsAny  :: a -> GenericBox a

showGenericBox :: GenericBox a -> String
showGenericBox (HoldsInt i)  = "the int is: " ++ show i
showGenericBox (HoldsBool b) = "the bool is: " ++ show b
showGenericBox (HoldsOrd _)  = "some ord..."
showGenericBox _             = "what's that?"

main :: IO ()
main = let
  x = HoldsInt 42
  -- x = HoldsOrd 42 -- try this
  -- x = HoldsAny 42 -- or this
  in putStrLn $ showGenericBox x
