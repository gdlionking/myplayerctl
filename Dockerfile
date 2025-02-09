FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    build-essential \
    meson \
    ninja-build \
    pkg-config \
    libglib2.0-dev \
    gobject-introspection \
    libgirepository1.0-dev \
    gtk-doc-tools \
    gir1.2-glib-2.0

WORKDIR /src
COPY . .

RUN meson setup builddir && \
    cd builddir && \
    ninja && \
    ninja install
