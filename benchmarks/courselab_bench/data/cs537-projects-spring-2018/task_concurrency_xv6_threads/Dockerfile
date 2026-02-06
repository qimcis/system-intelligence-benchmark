FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y git make gawk expect qemu-system-x86 gcc-multilib libc6-dev-i386 && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

RUN git clone https://github.com/remzi-arpacidusseau/ostep-projects.git && \
    cd ostep-projects && \
    git checkout 76cff3f89f4bf337af6e02e53a831b7eeb1396df && \
    rm -rf .git && \
    cd concurrency-xv6-threads && \
    git clone https://github.com/mit-pdos/xv6-public.git src && \
    cd src && \
    git checkout eeb7b415dbcb12cc362d0783e41c3d1f44066b17 && \
    rm -rf .git

# Remove any reference-solution directories
RUN rm -rf /workspace/ostep-projects/concurrency-xv6-threads/xv6-src-clean \
           /workspace/ostep-projects/concurrency-xv6-threads/xv6-src-mod \
           /workspace/ostep-projects/concurrency-xv6-threads/src/xv6-src-clean \
           /workspace/ostep-projects/concurrency-xv6-threads/src/xv6-src-mod
