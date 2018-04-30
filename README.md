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
2. gem install (Can skip if there is no change to Gemfile)
  (Described below)
3. Database creation (Can skip if there is no change to folder below)
  (Described below)
4. Start up 
  Execute the below command
    ```
      bundle exec rails s
    ```

# Gem install 
```
bundle _1.12.5_  install --path vendor/bundle
```
Execute the below command if there is no bundler bundler 1.12.5
```bash
gem install bundler -v 1.12.5
bundle _1.12.5_  install --path vendor/bundle
```

# Database creation
Execute the below command
```
bundle exec rails db:create
bundle exec rails db:migrate:reset
bundle exec rails db:seed_fu
```

# Rspec を用いたテスト
Create database for test environment 
```
bundle exec rails db:migrate:reset RAILS_ENV=test
```
Execute test
```
bundle exec rails spec 
```
Check the success condition for test if you change server side code
or commit after updateing test code
