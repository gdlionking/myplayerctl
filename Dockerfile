FROM ubuntu:latest

# 避免安装过程中的交互式提示
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# 设置时区
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 更新包列表并安装依赖
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    meson \
    ninja-build \
    pkg-config \
    libglib2.0-dev \
    gobject-introspection \
    libgirepository1.0-dev \
    gtk-doc-tools \
    gir1.2-glib-2.0 \
    python3-pip \
    dbus-x11 \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

WORKDIR /src
COPY . .

RUN meson setup builddir && \
    cd builddir && \
    ninja && \
    ninja install
