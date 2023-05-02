source 'https://rubygems.org'
ruby '2.6.5'

gem 'rails', '5.2.3'
gem 'sdoc', '~> 0.4.0', group: :doc

# Assets
gem 'bootstrap-sass'
gem 'font-awesome-rails'
gem 'jquery-rails'
gem 'sass-rails'
gem 'sassc', '2.1.0'
gem 'uglifier'
gem 'webpacker'

# UI/UX
gem 'rails-i18n', '~> 5.0.0'
# gem 'turbolinks'
gem 'jbuilder'
gem 'meta-tags'
gem 'slim-rails'

# Authentication
gem 'pundit'
gem 'sorcery'

# Configuration
gem 'config'
gem 'dotenv-rails', require: 'dotenv/rails-now'

# Database
gem 'sqlite3'
gem 'redis-rails'

# Seeds
gem 'seed-fu'

# Pagination
gem 'bootstrap4-kaminari-views'
gem 'kaminari'
gem 'kaminari-i18n'

# Breadcrumbs
gem 'gretel'

# Form
gem 'cocoon'
gem 'simple_form'

# Soft delete
gem 'paranoia'
gem 'paranoia_uniqueness_validator'

# Model
gem 'active_hash'
gem 'enum_help'

# Validation
gem 'validate_url'
gem 'validates_email_format_of'

# Decorator
gem 'active_decorator'

# Storage
gem 'aws-sdk-s3', require: false
gem 'mini_magick'

# Application server
gem 'puma'

# Background Job
gem 'resque'
gem 'whenever', require: false

# Debugger
group :development do
  gem 'listen'
  gem 'web-console'
end

group :development, :test do

  # Email
  gem 'letter_opener_web'

  # CLI
  gem 'spring'
  gem 'spring-commands-rspec'

  # Test
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'simplecov', require: false

  # Code analyze
  gem 'brakeman', require: false
  gem 'bullet'
  gem 'coffeelint'
  gem 'rails_best_practices'
  gem 'reek'
  gem 'rspec_junit_formatter'
  gem 'rubocop'
  gem 'rubocop-checkstyle_formatter'
  gem 'rubocop-rails'
  gem 'scss_lint', require: false
  gem 'slim_lint'

  # Debugger
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'byebug'
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'pry-rails'

  # Print debug
  gem 'awesome_print'
  gem 'tapp'

  # Table/Schema
  gem 'annotate', github: 'ctran/annotate_models', branch: 'develop'
  gem 'migration_comments'

  # Deploy
  gem 'capistrano', '3.9.0'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rails-console'
  gem 'capistrano-rbenv'
  gem 'capistrano-resque', require: false
  gem 'capistrano3-puma'
end

group :test do
  gem 'capybara'
  gem 'faker'
  gem 'fuubar'
  gem 'shoulda-matchers'
  gem 'timecop'
  gem 'webdrivers'
end
