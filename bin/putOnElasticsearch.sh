cd `dirname $0`
cd ../

dir='vendor/elasticsearch-2.4.3'
if [ -e $dir ]; then
    echo "Already put on (dir:$dir)"
else
    tar -xvf vendor/elasticsearch-2.4.3.tar.gz -C vendor/ &&
    sudo $dir/bin/plugin install analysis-kuromoji &&
    ./$dir/bin/plugin list &&
    echo "Successed put on!! (dir:$dir)"
fi