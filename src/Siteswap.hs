module Siteswap
  ( SiteswapState(..)
  , PropCount(..)
  , MaxThrow(..)
  , groundState
  , propCount
  , availableThrows
  , performThrow
  , showState
  ) where

import Data.Bits
import Data.Word

newtype SiteswapState = SiteswapState Word deriving (Eq)
newtype PropCount = PropCount Int
newtype MaxThrow = MaxThrow Int

groundState :: PropCount -> SiteswapState
groundState (PropCount n) = SiteswapState $ bit n - 1

propCount :: SiteswapState -> PropCount
propCount (SiteswapState s) = PropCount $ popCount s

showState :: MaxThrow -> SiteswapState -> String
showState (MaxThrow mt) (SiteswapState s) = map bin [mt, mt - 1..0]
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