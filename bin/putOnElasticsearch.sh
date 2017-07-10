cd `dirname $0/../`
tar -xvf vendor/elasticsearch-2.4.3.tar.gz -C vendor/ &&
sudo vendor/elasticsearch-2.4.3/bin/plugin install analysis-kuromoji &&
./vendor/elasticsearch-2.4.3/bin/plugin list