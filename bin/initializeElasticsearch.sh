curl -XDELETE 'localhost:9200/thesis_development?pretty' &&
curl -XPUT 'localhost:9200/thesis_development?pretty' -d '{
  "mappings" : {
    "thesis" : {
      "properties" : {
        "text" : {
          "type" : "string",
          "analyzer" : "kuromoji"
        }
      }
    }
  }
}' &&
curl -XGET 'localhost:9200/thesis_development/_mapping/thesis?pretty' &&
curl -XPUT 'localhost:9200/_settings' -d '{
  "index" : {
    "number_of_replicas" : 0
  }
}'
