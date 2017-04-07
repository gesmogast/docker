FROM rastasheep/ubuntu-sshd:16.04
MAINTAINER armagast@gmail.com
# nginx container

RUN apt-get update && apt-get install -y sudo nano git nginx openssh-server supervisor iproute2 software-properties-common
RUN mkdir -p /var/run/sshd /var/log/supervisor /run/php
COPY supervisord.conf /etc/supervisor/supervisord.conf

ADD install_magento.sh /home/
RUN ["chmod","+x","/home/install_magento.sh"]
RUN /home/install_magento.sh && rm /home/install_magento.sh

EXPOSE 22 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
