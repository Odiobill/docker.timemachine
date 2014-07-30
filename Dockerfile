# Time Machine backup server based on Debian
# VERSION               0.1
FROM debian
MAINTAINER Davide Lucchesi  "davide@lucchesi.nl"

RUN apt-get update
RUN apt-get dist-upgrade -y -q
RUN apt-get install -y -q netatalk
RUN apt-get clean

RUN sed -i 's/"Home Directory"/"Time Machine" options:usedots,upriv,tm/' /etc/netatalk/AppleVolumes.default
RUN echo '- -tcp -noddp -uamlist uams_dhx.so,uams_dhx2.so -nosavepassword -servername "Time Machine" -setuplog "default log_warn /var/log/timemachine/afpd.log"' >> /etc/netatalk/afpd.conf
RUN touch /etc/skel/.com.apple.timemachine.supported
RUN mkdir /var/log/timemachine
RUN useradd -m timemachine
RUN echo timemachine:timemachine | chpasswd
RUN touch /var/log/timemachine/afpd.log

VOLUME /etc
VOLUME /home
VOLUME /var/log/timemachine

EXPOSE 548

CMD service netatalk start && tail -f /var/log/timemachine/afpd.log

