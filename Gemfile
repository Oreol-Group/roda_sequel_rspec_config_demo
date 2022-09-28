# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem 'rake'
gem 'puma'

gem 'roda'
gem 'rack-unreloader'

gem 'i18n'
gem 'config'

gem 'sequel'
gem 'sequel_pg', require: 'sequel'

group :development do
  gem 'pry'
end

group :test do
  gem 'rspec'
  gem 'factory_bot'
  gem 'rack-test'
  gem 'database_cleaner-sequel'
end
