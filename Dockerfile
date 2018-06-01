FROM ubuntu:xenial
MAINTAINER ASCDC <asdc.sinica@gmail.com>

RUN mkdir /script
ADD run.sh /script/run.sh

RUN DEBIAN_FRONTEND=noninteractive && \
	chmod +x /script/*.sh && \
	apt-get -qq update && \
	apt-get -y -qq dist-upgrade && \
	apt-get -qq install -y locales apt-utils && \
	locale-gen en_US.UTF-8 && \
	export LANG=en_US.UTF-8
RUN DEBIAN_FRONTEND=noninteractive && \
	apt-get -qq install -y vim git wget curl sudo lsyncd openssh-server && \
	mkdir /etc/lsyncd && \
	touch /etc/lsyncd/lsyncd.conf.lua && \
	touch /etc/lsyncd/lsyncd.log && \
	touch /etc/lsyncd/lsyncd.status && \
	echo "settings {" >> /etc/lsyncd/lsyncd.conf.lua && \
	echo "	logfile      =\"/etc/lsyncd/lsyncd.log\"," >> /etc/lsyncd/lsyncd.conf.lua && \
	echo "	statusFile   =\"/etc/lsyncd/lsyncd.status\"," >> /etc/lsyncd/lsyncd.conf.lua && \
	echo "	maxProcesses = 8," >> /etc/lsyncd/lsyncd.conf.lua && \
	echo "	delay=10" >> /etc/lsyncd/lsyncd.conf.lua && \
    echo "}" >> /etc/lsyncd/lsyncd.conf.lua && \
	echo "sync {" >> /etc/lsyncd/lsyncd.conf.lua && \
    echo "	default.direct," >> /etc/lsyncd/lsyncd.conf.lua && \
    echo "	source    = \"/tmp/src\"," >> /etc/lsyncd/lsyncd.conf.lua && \
    echo "	target    = \"/tmp/dest\"," >> /etc/lsyncd/lsyncd.conf.lua && \
    echo "	delay = 1" >> /etc/lsyncd/lsyncd.conf.lua && \
    echo "	maxProcesses = 1" >> /etc/lsyncd/lsyncd.conf.lua && \
    echo "}" >> /etc/lsyncd/lsyncd.conf.lua
	
ENTRYPOINT ["/script/run.sh"]
