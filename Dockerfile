FROM centos:7
MAINTAINER imcat

COPY run /usr/local/bin/*
COPY rinetd /usr/local/bin/*
RUN chmod a+x /usr/local/bin/*
WORKDIR /etc/ocserv

RUN echo "Asia/Shanghai" > /etc/timezone

RUN yum install epel-release -y && yum install make gcc openssl-devel iptables iptables-services wget net-tools pam-devel libtalloc-devel gmp-devel systemd-devel nettle-devel gnutls-devel libev-devel libseccomp-devel libnl3-devel libnl-devel tcp_wrappers-devel lz4-devel lz4 radcli-devel radcli radcli-compat-devel liboath-devel geoip-devel protobuf-c protobuf-c-devel autogen autogen-libopts-devel libtalloc libtalloc-devel readline-devel readline-static unzip -y
RUN yum clean packages && yum clean headers && yum clean all
RUN rm -rf /var/cache/yum

# configuration ocserv
RUN mkdir -p /temp && cd /temp \
    && wget https://ocserv.gitlab.io/www/download.html \
    && export ocserv_version=$(cat download.html | grep -o '[0-9]*\.[0-9]*\.[0-9]*') \
    && wget ftp://ftp.infradead.org/pub/ocserv/ocserv-$ocserv_version.tar.xz \
    && tar xvf ocserv-$ocserv_version.tar.xz \
    && cd ocserv-$ocserv_version \
    && ./configure \
    && make && make install \
    && cd / && rm -rf /temp

CMD ["run"]
