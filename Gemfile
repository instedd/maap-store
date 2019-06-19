source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

gem 'active_model_serializers', '~> 0.10.0'
gem 'devise'
gem 'devise_token_auth'

group :development, :test do
  gem 'pry-rails'

  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'

  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'ffaker'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false

  gem 'guard'
  gem 'guard-rspec'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
