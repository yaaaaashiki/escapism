cd `dirname $0`
cd ../../../

yml_file='config/database.yml'
if [ -e $yml_file ]; then
    echo "Already exist (file:$yml_file)"
else
    cat bin/create_database_yml/development/yml_header >> $yml_file &&
    echo `mysql_config --socket` >> $yml_file &&
    cat bin/create_database_yml/development/yml_footer >> $yml_file &&
    echo "Create successed!! (file:$yml_file)"
    cat $yml_file
fi
