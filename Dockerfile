FROM ocaml/opam2:4.05

# Remove cached lsit from ocaml/opam2
RUN sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/*

# Install xlib, which is needed by AtomMap, and its dependencies
ARG XLIB_VERSION=master
RUN sudo apt-get update \
  && sudo apt-get install --yes --no-install-recommends \
    m4 libbz2-dev pkg-config wget zlib1g-dev \
  && opam install camlzip camlbz2 \
  && cd /home/opam \
  && wget --quiet --no-check-certificate --output-document=${XLIB_VERSION}.zip \
    https://github.com/w-jaworski/xlib/archive/${XLIB_VERSION}.zip \
  && unzip -qq ${XLIB_VERSION}.zip -d . \
  && rm -rf ${XLIB_VERSION}.zip \
  && cd /home/opam/xlib-${XLIB_VERSION} \
  && sed -i '1s|$| -I /home/opam/.opam/4.05/lib/zip|' makefile \
  && sed -i '1s|$| -I /home/opam/.opam/4.05/lib/bz2|' makefile \
  && eval $(opam env) \
  && make && make install \
  && cd /home/opam \
  && rm -rf /home/opam/xlib-${XLIB_VERSION} \
  && sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/*

# Install AtomMap and its dependencies
ARG ATOMMAP_VERSION=master
RUN opam install xml-light \
  && cd /home/opam \
  && wget --quiet --no-check-certificate --output-document=${ATOMMAP_VERSION}.zip \
    https://github.com/w-jaworski/AtomMap/archive/${ATOMMAP_VERSION}.zip \
  && unzip -qq ${ATOMMAP_VERSION}.zip -d . \
  && rm -rf ${ATOMMAP_VERSION}.zip \
  && cd /home/opam/AtomMap-${ATOMMAP_VERSION} \
  && sed -i '4s|$| -I /home/opam/.opam/4.05/lib/zip|' makefile \
  && sed -i '4s|$| -I /home/opam/.opam/4.05/lib/bz2|' makefile \
  && sed -i '4s|$| -I /home/opam/.opam/4.05/lib/xml-light|' makefile \
  && eval $(opam env) \
  && make \
  && sudo mkdir -p /work && sudo chown opam:opam -R /work \
  && mkdir -p /work/results \
  && cp chem_server2 /work \
  && cd /home/opam \
  && rm -rf /home/opam/AtomMap-${ATOMMAP_VERSION}

WORKDIR /work
CMD ["/work/chem_server2"]
