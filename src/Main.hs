import Siteswap

main :: IO ()
main = do
  let mt = MaxThrow 9
  let pc = PropCount 5
  let gs5 = groundState pc
  let s' = performThrow gs5 7
  putStrLn $ showState mt s'
  print $ availableThrows mt s'