# README

現実逃避の時間です  ∩( ´∀｀)∩ﾄﾞｳｿﾞ (っ´∀｀)っ))ﾖﾛｼｸ


# Ruby version

* 2.3.0


# Rails version

* 5.0.0


# System dependencies

* mysql 5.5以上
#### elasticsearch2.4.3使用時
* java7以上のJDK(oracleJDKとopenJDKのどちらでも可)
- JAVA_HOMEの設定  
(Javaをバージョン管理したかったらJenvを使用してください)

# elasticsearch2.4.3の設置方法(起動と停止以外は一回のみ行う)
## 設置
```bash
# 圧縮ファイルの解凍
tar -xvf vendor/elasticsearch-2.4.3.tar.gz
```

## 起動
```bash
./vendor/elasticsearch-2.4.3/bin/elasticsearch
```

## 停止
```bash
^C  (←Ctrl + C)
```

## 正常に動いてるかどうかの確認
```bash
curl 'localhost:9200/_cat/health'
# 以下のような出力でgreenになっていればOK
1483261560 09:06:00 elasticsearch green 1 1 0 0 0 0 0 0 - 100.0%
```

## 必要なプラグインのインストール
```bash
# 日本語で形態素解析をするのに使用
sudo vendor/elasticsearch-2.4.3/bin/plugin install analysis-kuromoji
# 正常にインストールされたことの確認(以下はelasticsearchを再起動してから行う)
./vendor/elasticsearch-2.4.3/bin/plugin list
# 以下のように"analysis-kuromoji"とあればOK
- analysis-kuromoji
```

# Gem install 

```
bundle install --path vendor/bundle
```

# Database creation

```
bundle exec rails db:create
bundle exec rails db:migrate:reset
bundle exec rails db:seed_fu
```

