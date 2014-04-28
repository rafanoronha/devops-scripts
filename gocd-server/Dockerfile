FROM phusion/baseimage:0.9.9
ADD . /var/scripts
RUN /var/scripts/gocd-server/setup
EXPOSE 8153
EXPOSE 8154
CMD ["/etc/init.d/go-server", "start"]
CMD /etc/init.d/go-server start && tail -f /var/log/go-server/go-server.log
