# README

現実逃避の時間です  ∩( ´∀｀)∩ﾄﾞｳｿﾞ (っ´∀｀)っ))ﾖﾛｼｸ


# Ruby version

* 2.3.0


# Rails version

* 5.0.0


# System dependencies

* mysql 5.5以上  
* java7以上のJDK(oracleJDKとopenJDKのどちらでも可)
* JAVA_HOMEの設定  
(Javaをバージョン管理したかったらJenvを使用してください)

# Gem install 

```
bundle _1.12.5_  install --path vendor/bundle
```
もし，bundler 1.12.5がなかったら以下のコマンドを打つ
```bash
gem install bundler -v 1.12.5
bundle _1.12.5_  install --path vendor/bundle
```

# Database creation
事前に Elasticsearch を起動しておく
```
bundle exec rails db:create
bundle exec rails db:migrate:reset
bundle exec rails db:seed_fu
```

# Rspec test 
プルリクを出す前に実行して, example 全部通っているか確認
```bash
bundle exec rails spec 
```



# Set up Elasticsearch2.4.3(起動と停止以外は一回のみ行う)
## put on Elasricsearch and install a plugin kuromoji to it
```bash
./bin/putOnElasticsearch.sh
```

## Start
```bash
./vendor/elasticsearch-2.4.3/bin/elasticsearch
```

## Check on the Elasticsearch running
```bash
curl 'localhost:9200/_cat/health'
# 以下のような出力でgreenになっていればOK
1483261560 09:06:00 elasticsearch green 1 1 0 0 0 0 0 0 - 100.0%
```

## Initialize Elasicsearch
起動中に以下を行う
```bash
./bin/initializeElasticsearch.sh
```

## Stop
使わないときに止める
```bash
^C  (←Ctrl + C)
```



