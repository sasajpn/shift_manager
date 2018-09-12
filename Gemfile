source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Core
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
gem 'puma', '~> 3.0'

# Views/Presentation
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.5'
gem 'autoprefixer-rails'
gem 'bootstrap_form'
gem 'kaminari'
gem 'active_decorator'
gem 'font-awesome-rails'

# DB/Model
gem 'mysql2', '>= 0.3.18', '< 0.5'
gem 'enum_help'
gem 'friendly_id'
gem 'banken'
gem 'redis'
gem 'redis-rails'
# gem 'virtus'

# Auhtenticate
gem 'devise'

# Support
gem 'chronic'

# Setting
gem 'config'
gem 'dotenv-rails'

# LINE
gem 'line-bot-api'

# Application Server
gem 'unicorn'
gem 'unicorn-worker-killer'

gem 'webpacker', github: 'rails/webpacker'

group :development, :test do
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'pry-byebug'
  gem 'byebug'
  gem 'annotate'
  gem 'awesome_print'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'shoulda-matchers'
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :development do
  gem 'foreman'
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'capistrano', '3.6.1'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler'
  gem 'capistrano3-unicorn'
  gem 'bullet'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'hirb'
  gem 'hirb-unicode'
  gem 'rubocop', require: false
  gem 'letter_opener'
  gem 'letter_opener_web'
end

group :test do
  gem 'rails-controller-testing'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
