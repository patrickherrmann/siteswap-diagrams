import Siteswap

main :: IO ()
main = do
  let sss@(SiteswapState s) = groundState (PropCount 4)
  let ts = availableThrows (MaxThrow 5) (SiteswapState 5)
  print ts