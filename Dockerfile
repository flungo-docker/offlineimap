FROM phusion/baseimage:0.9.16
MAINTAINER Arthur Axel fREW Schmdit <frioux@gmail.com>

CMD ["/sbin/my_init"]
VOLUME ["/opt/var/mail", "/opt/var/index", "/opt/log", "/opt/etc"]
EXPOSE 2812

ADD ./services/ /etc/service/user
ADD ./user_services /home/user/services
ADD ./offlineimaprc /home/user/.offlineimaprc
ADD ./offlineimap.py /home/user/.offlineimap.py
ADD ./bin/cerberus /home/user/bin/cerberus
ADD ./monitrc /home/user/.monitrc

ENV DEBIAN_FRONTEND noninteractive

RUN apt-add-repository -y ppa:rsrchboy/offline-mail \
 && apt-get update \
 && useradd user \
 && ln -s /opt/etc/netrc /home/user/.netrc \
 && ln -s /opt/var/index /home/user/.offlineimap \
 && chown 1000:1000 /opt/var/mail /opt/var/index /home/user -R \
 && apt-get install --no-install-recommends -y \
    daemontools                                \
    libio-all-perl                             \
    monit                                      \
    offlineimap                                \
    sudo
