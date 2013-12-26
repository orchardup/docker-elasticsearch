FROM charliek/oracle-jre-7
MAINTAINER Ben Firshman "ben@orchardup.com"

RUN wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
RUN echo "deb http://packages.elasticsearch.org/elasticsearch/0.90/debian stable main" >> /etc/apt/sources.list
RUN apt-get -qq update
RUN locale-gen en_US.UTF-8
RUN LC_ALL=en_US.UTF-8 DEBIAN_FRONTEND=noninteractive apt-get install -y -q elasticsearch

VOLUME ["/var/lib/elasticsearch"]
EXPOSE 9200
EXPOSE 9300
CMD ["service", "elasticsearch", "start"]
