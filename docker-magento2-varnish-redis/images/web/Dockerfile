FROM rastasheep/ubuntu-sshd:16.04
MAINTAINER armagast@gmail.com
# Installation of magento2 with nginx

RUN apt-get update && apt-get install -y nano sudo git openssh-server supervisor iproute2 nginx
RUN mkdir -p /var/run/sshd /var/log/supervisor /run/php
COPY supervisord.conf /etc/supervisor/supervisord.conf

ADD install_magento_requirements.sh /home/
ADD magento.conf /home/

RUN ["chmod","+x","/home/install_magento_requirements.sh"] 

RUN /home/install_magento_requirements.sh && rm /home/install_magento_requirements.sh

EXPOSE 22 80 443

VOLUME ["/var/www", "/etc/nginx/sites-available", "/var/log/nginx"]

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
