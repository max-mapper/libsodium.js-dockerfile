FROM ubuntu:18.04

RUN apt-get -qq -y update && apt-get -qq install -y --no-install-recommends \
    wget \
    git-core \
    ca-certificates \
    build-essential \
    file \
    python \
    python-pip \
    libxml2 \
    libtool-bin
RUN wget https://cmake.org/files/v3.9/cmake-3.9.4-Linux-x86_64.sh -q \
    &&  mkdir /opt/cmake \
    &&  printf "y\nn\n" | sh cmake-3.9.4-Linux-x86_64.sh --prefix=/opt/cmake > /dev/null \
    &&  ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake
RUN git clone https://github.com/emscripten-core/emsdk.git
RUN cd emsdk \
    && ./emsdk install sdk-latest-64bit \
    && ./emsdk activate sdk-latest-64bit
    # change above to sdk-incoming-64bit or something else if you need it
RUN git clone https://github.com/jedisct1/libsodium.js
RUN cd libsodium.js \
    # && git checkout 64065732d3b455f0c1d82b96b1cc06195c2553d7
RUN cd ./emsdk \
    && ./emsdk construct_env \
    && . ./emsdk_set_env.sh \    
    && cd ../libsodium.js \
    && make; exit 0
    # exit 0 is so config.log print line below will print even if build fails so you can debug
    # RUN cat ./libsodium.js/libsodium/config.log
RUN find ./libsodium.js/dist -type f -print0  | xargs -0 sha1sum > libsodium.js/dist/shasums.txt
