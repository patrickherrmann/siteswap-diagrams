import Siteswap
import Control.Applicative

nextStates :: MaxThrow -> SiteswapState -> [(Int, SiteswapState)]
nextStates mt s = do
  throw <- availableThrows mt s
  return (throw, performThrow s throw)

main :: IO ()
main = do
  let mt = MaxThrow 9
  let pc = PropCount 5
  let gs5 = groundState pc
  putStrLn . showState mt $ gs5