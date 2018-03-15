# Escapism
 青山学院大学・大学院 情報テクノロジー学科・知能情報コース 卒業・修士論文検索システム

# Ruby version

* 2.3.0


# Rails version

* 5.0.0


# System dependencies
各種インストール方法はwikiを参照([開発環境構築](https://github.com/yaaaaashiki/Escapism/wiki))
* mysql 5.7以上
* java7以上のJDK(oracleJDKとopenJDKのどちらでも可)
* Python3  
などなど

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

