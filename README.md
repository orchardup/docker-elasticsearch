docker-elasticsearch
====================

ElasicSearch for Docker.

    $ docker run -d -p 9200:9200 orchardup/elasticsearch
    da809981545f
    $ curl localhost:9200
    {
      "status" : 200,
      "name" : "Solarman",
      "version" : {
        "number" : "1.0.1",
        "build_hash" : "5c03844e1978e5cc924dab2a423dc63ce881c42b",
        "build_timestamp" : "2014-02-25T15:52:53Z",
        "build_snapshot" : false,
        "lucene_version" : "4.6"
      },
      "tagline" : "You Know, for Search"
    }

