FROM ocaml/opam2:ubuntu

RUN sudo apt-get update && sudo apt-get install -y libev-dev
RUN opam update
RUN sudo opam config env && sudo opam install depext && sudo opam depext conf-m4
RUN opam config env && opam depext conf-libev
RUN opam config env && opam install lwt
RUN mkdir /home/opam/hello
ADD config.ml unikernel.ml /home/opam/hello/
WORKDIR /home/opam/hello
RUN eval 'opam config env' && opam install mirage && mirage configure --xen && make
