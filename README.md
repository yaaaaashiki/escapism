# README

現実逃避の時間です  ∩( ´∀｀)∩ﾄﾞｳｿﾞ (っ´∀｀)っ))ﾖﾛｼｸ


# Ruby version

* 2.3.0


# Rails version

* 5.0.0


# System dependencies
各種インストール方法はwikiを参照([開発環境構築](https://github.com/yaaaaashiki/Escapism/wiki/%E9%96%8B%E7%99%BA%E7%92%B0%E5%A2%83%E6%A7%8B%E7%AF%89))
* mysql 5.5以上  
* java7以上のJDK(oracleJDKとopenJDKのどちらでも可)
* JAVA_HOMEの設定  
(Javaをバージョン管理したかったらJenvを使用してください)
* Python3  

## Pythonのパッケージ
- Pandas
- NumPy
- SciPy
- MeCab
- scikit-learn
- nltk

# 実行手順
1. elasticsearh起動  
  wiki参照[Elasticsearchの初期設定と使用法](https://github.com/yaaaaashiki/Escapism/wiki/Elasticsearch%E3%81%AE%E5%88%9D%E6%9C%9F%E8%A8%AD%E5%AE%9A%E3%81%A8%E4%BD%BF%E7%94%A8%E6%B3%95)
2. gem install (Gemfileに変更がなければ飛ばして良い)  
  (以下に記述)
3. Database creation (dbディレクトリ以下のファイルに変更がなければ飛ばして良い)  
  (以下に記述)
4. 起動  
  以下を実行
    ```
      bundle exec rails s
    ```

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
以下のコマンドをターミナルで打つ
```
bundle exec rails db:create
bundle exec rails db:migrate:reset
bundle exec rails db:seed_fu
```

# config/database.yml の配置
Mac の方は以下を database.yml に記述
```
default: &default
  adapter: mysql2
  encoding: utf8
  pool: 5
  username: root
  password:
  socket: /tmp/mysql.sock

development:
  <<: *default
  database: escapism_development

test:
  <<: *default
  database: escapism_test 
```

その他の環境の方は
```
mysql_config --socket
```
上記の実行結果を config/database.yml の socket:
の値に記述


# Rspec を用いたテスト
テスト用のデータベース作成
```
bundle exec rails db:migrate:reset RAILS_ENV=test
```
テストの実行
```
bundle exec rails spec 
```
