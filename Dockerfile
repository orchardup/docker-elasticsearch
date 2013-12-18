FROM charliek/oracle-jre-7
MAINTAINER Ben Firshman "ben@orchardup.com"

RUN apt-get install curl
RUN cd /opt; curl https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.7.tar.gz | tar -xzf - ; mv /opt/elasticsearch-* /opt/elasticsearch
VOLUME ["/opt/elasticsearch/data"]
EXPOSE 9200
EXPOSE 9300
CMD ["/opt/elasticsearch/bin/elasticsearch", "-f"]

