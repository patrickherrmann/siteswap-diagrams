import Siteswap
import Control.Applicative

nextStates :: MaxThrow -> SiteswapState -> [(Int, SiteswapState)]
nextStates mt s = [(t, performThrow s t) | t <- availableThrows mt s]

main :: IO ()
main = do
  let mt = MaxThrow 9
  let pc = PropCount 5
  let gs5 = groundState pc
  putStrLn . showState mt $ gs5