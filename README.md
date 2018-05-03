# Escapism
Graduation Theses Search System for Students Belonging to Follows
* Intelligence Information Course
* Department of Integrated Information Technology

# Ruby version

* 2.3.0

# Rails version

* 5.0.0

# System dependencies
About installation, refer to wiki ([Development Environment Construction](https://github.com/yaaaaashiki/Escapism/wiki)).
* MySQL 5.7 or higher
* Java Development Kit 7 or higher
* Python3  
etc...

# Execution procedure
1. Start up Elasticsearh  
  Refer to wiki ([How to Initialize and Use Elasticsearch](https://github.com/yaaaaashiki/Escapism/wiki/Elasticsearch%E3%81%AE%E5%88%9D%E6%9C%9F%E8%A8%AD%E5%AE%9A%E3%81%A8%E4%BD%BF%E7%94%A8%E6%B3%95)).

2. Install gem (only when you execute this app for the first time, or someone changed Gemfile)  
  (See described section below)

3. Create database (only when you execute this app for the first time, or someone changed files in db directory)  
  (See described section below)

4. Start up this app  
  Execute the following command.
    ```
      bundle exec rails s
    ```

# Gem install
Execute the following command if there is no bundler bundler
```bash
gem install bundler
bundle install --path vendor/bundle
```

# Database creation
Execute the following command.
```
bundle exec rails db:create
bundle exec rails db:migrate:reset
bundle exec rails db:seed_fu
```

# Test with Rspec 
Create database for test environment.
```
bundle exec rails db:migrate:reset RAILS_ENV=test
```
Execute test.
```
bundle exec rails spec 
```
Be sure that tests are all succeed, when you do the follows
- you change server side code
- commit after updateing test code.
