# forked from https://gist.github.com/jpetazzo/5494158

FROM	ubuntu:14.04
MAINTAINER	kload "kload@kload.fr"

# prevent apt from starting postgres right after the installation
RUN	echo "#!/bin/sh\nexit 101" > /usr/sbin/policy-rc.d; chmod +x /usr/sbin/policy-rc.d

RUN apt-get update
RUN locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8
RUN	LC_ALL=en_US.UTF-8 DEBIAN_FRONTEND=noninteractive apt-get install -y -q postgresql-9.3 postgresql-contrib-9.3
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get clean

# allow autostart again
RUN	rm /usr/sbin/policy-rc.d

ADD	start_pgsql.sh /usr/bin/start_pgsql.sh
RUN	chmod +x /usr/bin/start_pgsql.sh
RUN echo 'host all all 0.0.0.0/0 md5' >> /etc/postgresql/9.3/main/pg_hba.conf
RUN sed -i -e"s/var\/lib/opt/g" /etc/postgresql/9.3/main/postgresql.conf
