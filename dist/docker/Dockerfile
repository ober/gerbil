ARG distro
ARG with_db
ARG repo
ARG branch
ARG cores
ARG configure_args
ARG packages
ARG shared

FROM ${distro}:latest as base
ARG cores
ARG distro
ARG with_db
ARG packages
ENV PATH=/opt/gerbil/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin
ENV GERBIL_BUILD_CORES=$cores
ENV DEBIAN_FRONTEND=noninteractive
RUN mkdir -p /src /opt
RUN case ${distro} in \
    alpine) \
    apk update && \
    eval apk add ${packages} && \
    cd /src && test -n "${with_db}" && (git clone --recurse-submodules https://github.com/google/leveldb.git && cd /src/leveldb && git fetch --tags && git checkout 1.23 && mkdir -p build && cd build && cmake -DCMAKE_BUILD_TYPE=Release .. && cmake --build . -j $cores &&  mv libleveldb.a /usr/lib) || true \
    cd /src && test -n "${with_db}" && (git clone https://github.com/LMDB/lmdb && cd /src/lmdb/libraries/liblmdb && make && cd /src/lmdb/libraries/liblmdb && mv liblmdb.a /usr/lib) || true \
    ;; \
    amazonlinux) \
    amazon-linux-extras install epel -y && \
    yum update -y && yum groupinstall -y 'Development Tools' && \
    eval yum install -y ${packages} \
    ;; \
    fedora) \
    yum update -y && yum group install -y development-tools && \
    eval yum install -y ${packages} \
    ;; \
    debian|ubuntu) \
    apt update -y && \
    eval apt install -y ${packages} \
    ;; \
    *) \
    echo "Unknown distro ${distro}" \
    exit 2\
    ;; \
    esac

FROM base as gerbil
ARG branch
ARG configure_args
ARG cores
ARG repo
ARG shared
RUN cd /opt && eval git clone -b "${branch}" "https://github.com/${repo}" gerbil-src \
    && cd /opt/gerbil-src && eval ./configure --prefix=/opt/gerbil --enable-shared=${shared} ${configure_args}

RUN cd /opt/gerbil-src && make
RUN cd /opt/gerbil-src && make install

FROM gerbil as final
RUN rm -rf /opt/gerbil-src /src/leveldb /src/lmdb

WORKDIR /src
CMD ["gxi"]
