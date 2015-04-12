module Siteswap
  ( SiteswapState(..)
  , PropCount(..)
  , MaxThrow(..)
  , SiteswapEdge
  , groundState
  , propCount
  , availableThrows
  , performThrow
  , showState
  , getEdges
  ) where

import Data.Bits
import Data.Word
import Data.List
import Control.Applicative
import Control.Monad.State.Lazy

newtype SiteswapState = SiteswapState Word deriving (Eq)
newtype PropCount = PropCount Int
newtype MaxThrow = MaxThrow Int
type SiteswapEdge = (SiteswapState, SiteswapState, Int)

groundState :: PropCount -> SiteswapState
groundState (PropCount n) = SiteswapState $ bit n - 1

propCount :: SiteswapState -> PropCount
propCount (SiteswapState s) = PropCount $ popCount s

showState :: MaxThrow -> SiteswapState -> String
showState (MaxThrow mt) (SiteswapState s) = bin <$> [mt, mt - 1..0]
  where bin i
          | testBit s i = '1'
          | otherwise = '0'

availableThrows :: MaxThrow -> SiteswapState -> [Int]
availableThrows (MaxThrow mt) (SiteswapState s)
  | testBit s 0 = filter (not . testBit s) [1..mt]
  | otherwise = [0]

performThrow :: SiteswapState -> Int -> SiteswapState
performThrow (SiteswapState s) i = SiteswapState s'
  where s' = shiftR (setBit s i) 1

getOutEdges :: MaxThrow -> SiteswapState -> [SiteswapEdge]
getOutEdges mt s = [(s, performThrow s t, t) | t <- availableThrows mt s]

getEdges' :: MaxThrow -> SiteswapState -> State [SiteswapState] [SiteswapEdge]
getEdges' mt s = do
  let edges = getOutEdges mt s
  let (_, neighbors, _) = unzip3 edges
  visited <- get
  put (s:visited)
  foldM (\es n -> (es ++) <$> getEdges' mt n) edges (neighbors \\ visited)

getEdges :: MaxThrow -> SiteswapState -> [SiteswapEdge]
getEdges mt s = evalState (getEdges' mt s) []