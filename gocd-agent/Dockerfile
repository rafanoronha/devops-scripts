FROM phusion/baseimage:0.9.9
ADD . /var/scripts
RUN /var/scripts/gocd-agent/setup node phantomjs
VOLUME ["/var/lib/go-agent"]
CMD java -jar /usr/share/go-agent/agent-bootstrapper.jar $SERVER_PORT_8153_TCP_ADDR $SERVER_PORT_8153_TCP_PORT
