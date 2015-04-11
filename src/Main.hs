import Siteswap
import Control.Applicative
import Control.Monad.State.Lazy
import Data.List

nextStates :: MaxThrow -> SiteswapState -> [(Int, SiteswapState)]
nextStates mt s = [(t, performThrow s t) | t <- availableThrows mt s]

createGraph' :: MaxThrow -> SiteswapState -> State [SiteswapState] [(SiteswapState, SiteswapState, Int)]
createGraph' mt s = do
  let ss' = nextStates mt s
  let edge (i, s') = (s, s', i)
  let edges = map edge ss'
  visited <- get
  let neighbors = map snd ss' \\ visited
  put (s:visited)
  foldM (\es n -> (++ es) <$> createGraph' mt n) edges neighbors

createGraph :: MaxThrow -> SiteswapState -> [(SiteswapState, SiteswapState, Int)]
createGraph mt s = evalState (createGraph' mt s) []

main :: IO ()
main = do
  let mt = MaxThrow 5
  let pc = PropCount 3
  let gs5 = groundState pc
  let edges = createGraph mt gs5
  let showEdge (a, b, l) = print (showState mt a, showState mt b, l)
  mapM_ showEdge edges