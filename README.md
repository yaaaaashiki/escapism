# README

現実逃避の時間です  ∩( ´∀｀)∩ﾄﾞｳｿﾞ (っ´∀｀)っ))ﾖﾛｼｸ


# Ruby version

* 2.3.0


# Rails version

* 5.0.0


# System dependencies

* mysql 5.5以上  
### To use elasticsearch2.4.3
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

# Set up Elasticsearch2.4.3(起動と停止以外は一回のみ行う)
## Expand Elasticsearch2.4.3's tar.gz to vendor/
```bash
# 圧縮ファイルの解凍
tar -xvf vendor/elasticsearch-2.4.3.tar.gz -C vendor/
```

## Start
```bash
./vendor/elasticsearch-2.4.3/bin/elasticsearch
```

## Stop
```bash
^C  (←Ctrl + C)
```

## Check on the Elasticsearch running
```bash
curl 'localhost:9200/_cat/health'
# 以下のような出力でgreenになっていればOK
1483261560 09:06:00 elasticsearch green 1 1 0 0 0 0 0 0 - 100.0%
```

## Install a necessary plugin to analyze Japanese
```bash
# 日本語で形態素解析をするのに使用
sudo vendor/elasticsearch-2.4.3/bin/plugin install analysis-kuromoji
# 正常にインストールされたことの確認
./vendor/elasticsearch-2.4.3/bin/plugin list
# 以下のように"analysis-kuromoji"とあればOK
- analysis-kuromoji
# Elasticsearchの再起動を行う
^C
./vendor/elasticsearch-2.4.3/bin/elasticsearch
```

## Create a index onto the Elasticsearch
rails consoleで以下を実行
```bash
Thesis.__elasticsearch__.create_index! force: true # Elasticsearchのインデックスを削除
Thesis.__elasticsearch__.refresh_index! # Elasticsearchのインデックスを作成
```

# Database creation

```
bundle exec rails db:create
bundle exec rails db:migrate:reset
bundle exec rails db:seed_fu
```

