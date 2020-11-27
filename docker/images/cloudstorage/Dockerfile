ARG DESKTOP_ENVIRONMENT_BASE
FROM $DESKTOP_ENVIRONMENT_BASE:latest

# Install cloudstorage
RUN sudo apt-get install -qq \
  autoconf \
  fuse3 \
  libcurl4-openssl-dev \
  libfuse3-dev \
  libjsoncpp-dev \
  libmicrohttpd-dev \
  libtinyxml2-dev \
  libtool \
  pkg-config && \
  git clone --depth 1 https://github.com/cloud-computer/libcloudstorage && \
  cd libcloudstorage && \
  ./bootstrap && \
  ./configure --with-curl --with-microhttpd --with-fuse && \
  make -j$(nproc) && \
  sudo make install && \
  echo user_allow_other | sudo tee -a /etc/fuse.conf && \
  mkdir -p ~/.config/cloudstorage ~/cloudstorage

# Start cloudstorage
ENTRYPOINT ["/usr/local/bin/cloudstorage-fuse"]
