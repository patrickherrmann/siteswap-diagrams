# Siteswap Diagrams

This utility takes in a number of props and a maximum throw height, from which it generates a graphical representation of all siteswap patterns. Output is *dot* code, which can be rendered using graphviz to a variety of image formats.

Each vertex is a state, representing the height of each object. Each edge is a throw, which progresses time and changes the state of the pattern. The number given to each edge is the height of the throw.

The ground state has all of its *1*'s on the left, e.g. *111000* for 3 prop ground state. Every ground state has a loop; throwing a *3* from the 3 prop ground state yields the 3 prop ground state.

Each cycle in the graph is a loopable pattern. Cycles that pass through the ground state are ground state patterns, and cycles that don't are excited state patterns. Finding transitions from one pattern to another is as easy as finding paths from cycle to another.

## Usage

Build with [stack](https://github.com/commercialhaskell/stack):

```
$ stack build
```

Usage is documented with `--help`:

```
$ stack exec -- siteswap --help
Generate siteswap state diagrams

Usage: siteswap (-p|--props N) (-m|--maxThrow H)
  Generate siteswap state diagrams, rendered in dot format. Pipe output into
  'dot' to render the graph in a variety of input formats.

Available options:
  -h,--help                Show this help text
  -p,--props N             Juggle N props
  -m,--maxThrow H          Ignore throws higher than H
```

The resulting dot code can be piped into `dot` to render an image:

```
$ ./dist/build/siteswap/siteswap -p 3 -m 5 | dot -Tpng -o image.png
```

## Example

The command above renders the image below: 3 prop patterns with a max height of *5*. Notice the ground state *111000* with a loop. This is the basic three prop cascade. You can find every siteswap as a path through the graph, e.g. *441*, *531*, *45141*, etc.

There is a *51* cycle between *110100* and *101010*, which is the shower pattern. You can find the transitions from cascade to shower visually. Transitions to shower include *4*, *52*, and *5350*; transitions back to cascade include *2*, *41*, *440*, and *530*.

![p3m5](http://i.imgur.com/NMNKaxZ.png?1)