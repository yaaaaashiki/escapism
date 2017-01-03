cd `dirname $0`
curl -XDELETE 'localhost:9200/thesis_development?pretty' &&
curl -XPUT 'localhost:9200/thesis_development?pretty' -d '{
  "mappings" : {
    "thesis" : {
      "properties" : {
        "author" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "year" : {
          "type" : "string"
        },
        "comment" : {
          "type" : "string",
          "analyzer" : "kuromoji"
        },
        "url" : {
          "type" : "string"
        },
        "text" : {
          "type" : "string",
          "analyzer" : "kuromoji"
        }
      }
    }
  }
}'
curl -XGET 'localhost:9200/thesis_development/_mapping/thesis?pretty'
