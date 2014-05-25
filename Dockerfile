FROM charliek/openjdk-jre-7
MAINTAINER Ben Firshman "ben@orchardup.com"

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y curl sudo
RUN curl http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
RUN echo "deb http://packages.elasticsearch.org/elasticsearch/1.2/debian stable main" >> /etc/apt/sources.list
RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive apt-get install -y elasticsearch
ADD run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run

EXPOSE 9200 9300
VOLUME ["/var/lib/elasticsearch"]
CMD ["/usr/local/bin/run"]
