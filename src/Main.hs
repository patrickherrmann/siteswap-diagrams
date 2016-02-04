{-# LANGUAGE OverloadedStrings #-}

import CLI
import Siteswap
import Data.GraphViz.Types.Canonical
import Data.GraphViz.Printing
import Data.GraphViz.Attributes
import Data.List
import qualified Data.Text.Lazy as T
import qualified Data.Text.Lazy.IO as T

main :: IO ()
main = do
  opts <- parseOptions
  let pc = PropCount $ props opts
  let mt = MaxThrow $ maxThrow opts
  let gs = groundState pc
  let edges = getEdges mt gs
  let (nodes, _, _) = unzip3 edges
  let dotEdges = dotEdge mt <$> edges
  let dotNodes = dotNode mt <$> nub nodes
  T.putStrLn . renderDot . toDot $ createDotGraph dotNodes dotEdges

dotEdge :: MaxThrow -> SiteswapEdge -> DotEdge String
dotEdge mt (from, to, throw) = DotEdge
  { fromNode = showState mt from
  , toNode = showState mt to
  , edgeAttributes =
    [ textLabel . T.pack . show $ throw
    , color Gray50
    ]
  }

dotNode :: MaxThrow -> SiteswapState -> DotNode String
dotNode mt s = DotNode
  { nodeID = showState mt s
  , nodeAttributes = [shape Circle]
  }

createDotGraph :: [DotNode String] -> [DotEdge String] -> DotGraph String
createDotGraph ns es = DotGraph
  { strictGraph = True
  , directedGraph = True
  , graphID = Just (Str "Siteswap")
  , graphStatements = DotStmts
    { attrStmts = []
    , subGraphs = []
    , nodeStmts = ns
    , edgeStmts = es
    }
  }