FROM ubuntu:latest

ENV container docker
STOPSIGNAL SIGRTMIN+3
VOLUME [ "/tmp", "/run", "/run/lock" ]
WORKDIR /

RUN apt update && apt upgrade -y
RUN apt install -y curl 
RUN apt install -y wget 
RUN apt install -y gpg 
RUN apt install -y lsb-release 
RUN apt install -y systemd systemd-sysv
RUN apt install -y vim iputils-ping
RUN apt clean

RUN cd /lib/systemd/system/sysinit.target.wants/ \
    && ls | grep -v systemd-tmpfiles-setup | xargs rm -f $1

RUN curl -sSL https://repo.45drives.com/setup | bash
RUN apt update && apt install -y cockpit-ceph-deploy

RUN systemctl enable cockpit.service

RUN echo "root:root" | chpasswd

CMD ["/lib/systemd/systemd"]

