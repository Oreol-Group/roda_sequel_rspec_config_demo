# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem 'rake'
gem 'puma'

gem 'roda', require: 'roda'
gem 'rack', '= 2.2.4'
gem 'rack-unreloader', require: 'rack/unreloader'

gem 'i18n', require: 'i18n'
gem 'config'

gem 'sequel'
gem 'sequel_pg', require: 'sequel'

gem 'activesupport', require: false

gem 'dry-initializer'
gem 'dry-validation'

group :development do
  gem 'pry'
  gem 'rubocop', require: false
end

group :test do
  gem 'rspec'
  gem 'factory_bot'
  gem 'rack-test'
  gem 'database_cleaner-sequel'
end
