{-# LANGUAGE OverloadedStrings #-}

import Siteswap
import Data.GraphViz.Types.Canonical
import Data.GraphViz.Printing
import qualified Data.Text.Lazy.IO as T

dotEdge :: MaxThrow -> SiteswapEdge -> DotEdge String
dotEdge mt (from, to, throw) = DotEdge {
  fromNode = showState mt from,
  toNode = showState mt to,
  edgeAttributes = []
}

createDotGraph :: MaxThrow -> [SiteswapEdge] -> DotGraph String
createDotGraph mt es = DotGraph {
  strictGraph = True,
  directedGraph = True,
  graphID = Just (Str "Siteswap"),
  graphStatements = DotStmts {
    attrStmts = [],
    subGraphs = [],
    nodeStmts = [],
    edgeStmts = map (dotEdge mt) es
  }
}

main :: IO ()
main = do
  let mt = MaxThrow 5
  let pc = PropCount 3
  let gs5 = groundState pc
  let edges = getEdges mt gs5
  let code = renderDot . toDot $ createDotGraph mt edges
  T.putStrLn code