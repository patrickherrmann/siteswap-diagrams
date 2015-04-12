# Siteswap Diagrams

This utility takes in a number of props and a maximum throw height, from which it generates a graphical representation of all siteswap patterns. Output is "dot" code, which can be rendered using graphviz to a variety of image formats.

Each vertex represents a state. The state represents the height of each object, and thus the timing for each to fall. Each edge is a throw, which progresses time and changes the state of the pattern. The number given to each edge is the height of the throw.

The ground state has all of its 1's on the left, e.g. 1110 for 3 prop ground state. Every ground state has a loop; throwing a 3 from 3 prop ground state yields the three prop ground state.

Each cycle in the graph is a loopable pattern. Cycles that pass through the ground state are ground state patterns, and cycles that don't are excited state patterns. Finding transitions between patterns is as easy as finding paths from one to the other.

## Usage

To build:

```
$ cabal sandbox init
$ cabal install --only-dependencies
$ cabal build
```

Usage:

```
$ ./dist/build/siteswap/siteswap --help
Generate siteswap state diagrams

Usage: siteswap (-p|--props N) (-m|--maxThrow H)
  Generate siteswap state diagrams, rendered in dot format. Pipe output into
  'dot' to render the graph in a variety of input formats.

Available options:
  -h,--help                Show this help text
  -p,--props N             Juggle N props
  -m,--maxThrow H          Ignore throws higher than H
```

Rendering images with graphviz:

```
$ ./dist/build/siteswap/siteswap -p 3 -m 5 | dot -Tpng -o image.png
```

## Example

The command above renders the image below; 3 prop patterns with max height 5. Notice the ground state 111000 with a loop. This is the basic three prop cascade. You can find every siteswap as a path through the graph, e.g. 441, 531, 45141, etc.

![p3m5](http://i.imgur.com/NMNKaxZ.png?1)