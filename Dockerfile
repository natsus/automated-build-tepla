from ubuntu:14.04
maintainer natsu

# ミラーサーバの設定(apt-getの高速化)
# run echo "deb http://jp.archive.ubuntu.com/ubuntu/ saucy main restricted\n\
# deb-src http://jp.archive.ubuntu.com/ubuntu/ saucy main restricted\n\
# deb http://jp.archive.ubuntu.com/ubuntu/ saucy-updates main restricted\n\
# deb-src http://jp.archive.ubuntu.com/ubuntu/ saucy-updates main restricted\n\
# deb http://jp.archive.ubuntu.com/ubuntu/ saucy universe\n\
# deb-src http://jp.archive.ubuntu.com/ubuntu/ saucy universe\n\
# deb http://jp.archive.ubuntu.com/ubuntu/ saucy-updates universe\n\
# deb-src http://jp.archive.ubuntu.com/ubuntu/ saucy-updates universe\n\
# deb http://jp.archive.ubuntu.com/ubuntu/ saucy multiverse\n\
# deb-src http://jp.archive.ubuntu.com/ubuntu/ saucy multiverse\n\
# deb http://jp.archive.ubuntu.com/ubuntu/ saucy-updates multiverse\n\
# deb-src http://jp.archive.ubuntu.com/ubuntu/ saucy-updates multiverse\n\
# deb http://jp.archive.ubuntu.com/ubuntu/ saucy-backports main restricted universe multiverse\n\
# deb-src http://jp.archive.ubuntu.com/ubuntu/ saucy-backports main restricted universe multiverse\n\
# deb http://security.ubuntu.com/ubuntu saucy-security main restricted\n\
# deb-src http://security.ubuntu.com/ubuntu saucy-security main restricted\n\
# deb http://security.ubuntu.com/ubuntu saucy-security universe\n\
# deb-src http://security.ubuntu.com/ubuntu saucy-security universe\n\
# deb http://security.ubuntu.com/ubuntu saucy-security multiverse\n\
# deb-src http://security.ubuntu.com/ubuntu saucy-security multiverse\n"> /etc/apt/sources.list

# aptで対話しない
# env DEBIAN_FRONTEND noninteractive

run apt-get update 
run apt-get install -y gcc wget git xz-utils m4 build-essential --no-install-recommends

# openssl install
workdir /tmp
run wget http://www.openssl.org/source/openssl-1.0.2d.tar.gz && \
    tar xvfz openssl-1.0.2d.tar.gz
workdir openssl-1.0.2d
run ./config --prefix=/usr/local shared && \
    make && \
    make test && \
    make install

# gmp install
workdir /tmp
run wget --no-check-certificate https://gmplib.org/download/gmp/gmp-6.0.0a.tar.xz && \
    tar Jxvf gmp-6.0.0a.tar.xz 
workdir gmp-6.0.0/
run ./configure --prefix=/usr/local --enable-cxx && \
    make && \
    make check && \
    make install

# tepla install
workdir /tmp
run wget http://www.cipher.risk.tsukuba.ac.jp/tepla/download/tepla-1.0.tar.gz && \
    tar zxvf tepla-1.0.tar.gz
workdir tepla-1.0
run ./configure && \
    make && \
    make check && \
    make install

workdir /
run rm -rf /tmp/*
# キャッシュの削除(イメージの容量削減)
run apt-get upgrade -y && apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* 
# aptで対話するように戻す
# env DEBIAN_FRONTEND dialog

# サンプルファイルの追加
add sample /root/sample
