# Escapism
Graduation Thesis Search System
Intelligence Information Course of Aoyama Gakuin University, University Graduate School, Department Of Integrated Information Technology 

# Ruby version

* 2.3.0

# Rails version

* 5.0.0

# System dependencies
Preference this wiki to refer to various installation procedure ([Construction Of Develop Environment](https://github.com/yaaaaashiki/Escapism/wiki))
* mysql 5.7 or higher
* JDK of java7 or higher (oracleJDK or openJDK, whichever will be fine)
* Python3  
etc...

# Execution procedure
1. Start up elasticsearh
  Preference wiki [Initial Setting And How To Use Of Elasticsearch](https://github.com/yaaaaashiki/Escapism/wiki/Elasticsearch%E3%81%AE%E5%88%9D%E6%9C%9F%E8%A8%AD%E5%AE%9A%E3%81%A8%E4%BD%BF%E7%94%A8%E6%B3%95)
  
2. gem install (Gemfileに変更がなければ飛ばして良い)  
2. gem install (Can skip if there is no change to Gemfile)
  (Described below)
3. Database creation (dbディレクトリ以下のファイルに変更がなければ飛ばして良い)  
3. Database creation (Can skip if there is no change to folder below)
  (Described below)
4. Start up 
  Execute below script 
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

# Rspec を用いたテスト
テスト用のデータベース作成
```
bundle exec rails db:migrate:reset RAILS_ENV=test
```
テストの実行
```
bundle exec rails spec 
```
サーバサイド変更時にはテストが通ることを確認、またはテスト更新後コミットしてください

