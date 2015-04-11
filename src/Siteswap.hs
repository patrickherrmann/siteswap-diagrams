module Siteswap
  ( SiteswapState(..)
  , PropCount(..)
  , MaxThrow(..)
  , groundState
  , propCount
  , availableThrows
  ) where

import Data.Bits
import Data.Word

newtype SiteswapState = SiteswapState Word
newtype PropCount = PropCount Int
newtype MaxThrow = MaxThrow Int

mask :: Int -> Word
mask n = bit n - 1

groundState :: PropCount -> SiteswapState
groundState (PropCount n) = SiteswapState $ mask n

propCount :: SiteswapState -> PropCount
propCount (SiteswapState s) = PropCount $ popCount s

availableThrows :: MaxThrow -> SiteswapState -> [Int]
availableThrows (MaxThrow mt) (SiteswapState s)
  | testBit s 0 = filter (not . testBit s) [1..mt]
  | otherwise = [0]

performThrow :: SiteswapState -> Int -> SiteswapState
performThrow (SiteswapState s) i = SiteswapState s'
  where s' = shiftR (setBit s i) 1