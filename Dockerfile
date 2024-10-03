FROM alpine:latest

RUN apk add --no-cache git gcc make musl-dev bash \
  pkgconfig upx fuse-static fuse-dev glib-dev \
  glib-static attr-dev attr-static

RUN git clone https://github.com/ruanformigoni/ciopfs.git

WORKDIR ciopfs

ENV LDFLAGS="-static"

RUN make

# Strip
RUN strip -s -R .comment -R .gnu.version --strip-unneeded ciopfs

# Compress
# RUN upx --ultra-brute --no-lzma ciopfs
