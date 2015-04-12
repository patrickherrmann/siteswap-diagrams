module CLI
  ( Options(..)
  , optParser
  ) where

import Options.Applicative

data Options = Options
  { props :: Int
  , maxThrow :: Int
  }

parseProps = option auto
  $  long "props"
  <> short 'p'
  <> metavar "N"
  <> help "Juggle N props"

parseMaxThrow = option auto
  $  long "maxThrow"
  <> short 'm'
  <> metavar "H"
  <> help "Ignore throws higher than H"

parseOptions = Options
  <$> parseProps
  <*> parseMaxThrow

optParser = info (helper <*> parseOptions)
           $  fullDesc
           <> header "Generate siteswap state diagrams"
           <> progDesc "Generate siteswap state diagrams, rendered in dot format.\
                       \ Pipe output into 'dot' to render the graph in a variety\
                       \ of input formats."