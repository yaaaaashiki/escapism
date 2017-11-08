#
source 'https://rubygems.org'

gem 'rails', '5.0.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby
# AP server
gem 'puma'

# Use Unicorn as the app server
gem 'unicorn'

#a aUI/UX
gem 'jquery-rails'
gem 'bootstrap-sass'
gem 'twitter-bootstrap-rails'
# gem 'twitter-bootstrap-rails-confirm'
# gem 'font-awesome-rails'
# gem 'font-awesome-sass', '~> 4.5.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'uglifier', '>= 1.3.0'
gem 'sass-rails', '~> 5.0'
gem 'jbuilder', '~> 2.0'
# gem 'jquery-ui-rails'
# gem 'dropzonejs-rails'
# gem 'compass-rails'
gem 'bootstrap_form'
# gem 'execjs'
# gem 'bourbon'
gem 'natto'
gem 'impressionist', '~> 1.5.1'

# Term Frequency - Inverse Document Frequency in Ruby http://redwriteshere.com
gem 'tf_idf'

#template engine
gem "slim"

# Authentication
# gem 'devise'
# gem 'devise-i18n'
gem 'sorcery'
gem 'cancancan'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

gem 'nokogiri'

# Admin
gem 'adminlte2-rails'

gem 'dotenv-rails'

# Search/Pagination
gem 'kaminari'
gem 'ransack'

# Seeds
gem 'seed-fu'

# Use sqlite3 as the database for Active Record
#gem 'sqlite3'
gem 'mysql2', '~> 0.3.17'



# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'jquery-turbolinks'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

#  Elasticsearch integrations for ActiveModel/Record and Ruby on Rails 
# https://github.com/elastic/elasticsearch-rails
gem 'elasticsearch-model', '2.0.1'
gem 'elasticsearch-rails', '2.0.1'
gem 'elasticsearch-dsl', '0.1.5'

# Read text and metadata from files and documents (.doc, .docx, .pages, .odt, .rtf, .pdf) http://github.com/Erol/yomu
gem 'yomu', '0.1.5'


# understandable model 
gem 'annotate'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do 
  gem 'database_cleaner'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'rails-controller-testing' 
end

# Test
group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'simplecov', require: false
  gem "faker"

  # Debugger
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'better_errors'
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'pry-stack_explorer'
end

group :production do 
  gem 'google-analytics-rails'
end

