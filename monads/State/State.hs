{-# LANGUAGE MultiWayIf #-}
import Control.Monad.State

data Oven = Oven { temperature :: Int } deriving Show
type BreadCount = Int

warmUp :: Int -> State Oven BreadCount
warmUp temp = do
  current <- get
  _ <- put $ Oven $ (temperature current) + temp -- warm up the oven by adding 80 degrees to the current temperature
  return 0                                       -- warming up does not yield any new breads

coolDown :: State Oven BreadCount
coolDown = do
  current <- get
  _ <- put $ Oven $ (temperature current) - 50   -- cool down the oven by subtracting 50 degrees from the current temperature
  return 0                                       -- cooling down does not yield any new breads

bake :: State Oven BreadCount
bake = do
  current <- get
  let temp = temperature current
  if | temp > 90 && temp < 150 -> return 1       -- if oven's temperature is within the desired range, yield one new bread
     | otherwise -> return 0                     -- the oven is either too cold or too warm! yield no new breads

logic :: State Oven BreadCount
logic = do
  _        <- warmUp 90
  fstYield <- bake
  sndYield <- bake
  _        <- coolDown
  return $ fstYield + sndYield

analyze :: (BreadCount, Oven) -> String
analyze (breadCount, oven) =
  "Bread count is "                     ++
  show breadCount                       ++
  " and the oven has a temperature of " ++ 
  (show $ temperature $ oven)           ++
  " degrees."

initialOven :: Oven
initialOven = Oven 20

main :: IO ()
main = putStrLn $ analyze $ runState logic initialOven
