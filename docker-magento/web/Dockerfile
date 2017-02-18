FROM rastasheep/ubuntu-sshd:16.04
MAINTAINER armagast@gmail.com
# Installation of magento2 with nginx

RUN apt-get update && apt-get install -y openssh-server supervisor
RUN mkdir -p /var/run/sshd /var/log/supervisor
COPY supervisord.conf /etc/supervisor/supervisord.conf

ADD install_magento.sh /home/
ADD magento.conf /home/

RUN ["chmod","+x","/home/install_magento.sh"] 

RUN /home/install_magento.sh && rm /home/install_magento.sh

#RUN mkdir /var/lib/mysql

EXPOSE 22 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
