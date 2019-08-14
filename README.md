# atom-map-docker

This is a Docker image for Atom Map by Wojciech Jaworski, et al.

## Quick Start

Install [Docker](https://docs.docker.com/install/) if you don't have one already.
Build a Docker image:

```bash
docker build . --tag arontier/atom-map
```

You just need this once. The next step however needs to be done whenever
you wish to run `chem_server2`.

```bash
docker run --rm -it arontier/atom-map
```

This will run `chem_server2`. 

For more information, please refer to [Docker documentation](https://docs.docker.com/).

Enjoy. :-)

## References

* [Automatic mapping of atoms across both simple and complex chemical reactions](https://www.nature.com/articles/s41467-019-09440-2)
* [Docker Install](https://docs.docker.com/install/)
* [Docker documentation](https://docs.docker.com/)
* [OCaml Manual](http://caml.inria.fr/pub/docs/manual-ocaml/)
* [OCaml Package Documents](https://opam.ocaml.org/packages/)
* [Wojciech Jaworski's Atom Map](https://github.com/w-jaworski/AtomMap)
* [Wojciech Jaworski's Xlib](https://github.com/w-jaworski/xlib)
