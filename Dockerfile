FROM centos
MAINTAINER imcat

COPY rinetd /usr/local/bin/rinetd
COPY run /usr/local/bin/run
RUN ["chmod", "a+x", "/usr/local/bin/rinetd"]
RUN ["chmod", "a+x", "/usr/local/bin/run"]
WORKDIR /etc/ocserv
RUN echo "Asia/Shanghai" > /etc/timezone
RUN yum install epel-release -y && yum install make gcc openssl-devel iptables iptables-services wget net-tools pam-devel libtalloc-devel gmp-devel systemd-devel nettle-devel gnutls-devel libev-devel libseccomp-devel libnl3-devel libnl-devel tcp_wrappers-devel lz4-devel lz4 radcli-devel radcli radcli-compat-devel liboath-devel geoip-devel protobuf-c protobuf-c-devel autogen autogen-libopts-devel libtalloc libtalloc-devel readline-devel readline-static unzip ocserv -y
RUN yum clean packages && yum clean headers && yum clean all
RUN rm -rf /var/cache/yum
CMD ["run"]
