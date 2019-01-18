# Escapism
The graduation theses search system for students belonging to following
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

2. Install gems (only when you execute this app for the first time, or someone changed `Gemfile`)  
  (See a section described in below)

3. Create your database (only when you execute this app for the first time, or someone changed files in the `db` directory)  
  (See a section described in below)

4. Start up this app  
  Execute the following command.
    ```
      bundle exec rails s
    ```

# Gems installation
Execute the following command if there is no bundler
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

# Tests with Rspec 
Create a database for test environment.
```
bundle exec rails db:migrate:reset RAILS_ENV=test
```
Execute our tests.
```
bundle exec rails spec 
```
Be sure that these tests are all succeed, when you do the following
- you change server-side codes.
- commit after updateing test codes.

# Tests with stylelint
This app checks stylesheet syntax with stylelint.
Run our tests when running this app's server.
We want you to create pull requests after you confirm the tests are all succeed using them.

Execute the tests.
```
bundle exec rails server
```
If puma's server is running, all tests succeed.

