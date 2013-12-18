docker-elasticsearch
====================

ElasicSearch for Docker.

    $ docker run -d -p 9200:9200 orchardup/elasticsearch
    da809981545f
    $ curl localhost:9200
    {
      "ok" : true,
      "status" : 200,
      "name" : "Spider-Slayer",
      "version" : {
        "number" : "0.90.7",
        "build_hash" : "36897d07dadcb70886db7f149e645ed3d44eb5f2",
        "build_timestamp" : "2013-11-13T12:06:54Z",
        "build_snapshot" : false,
        "lucene_version" : "4.5.1"
      },
      "tagline" : "You Know, for Search"
    }

