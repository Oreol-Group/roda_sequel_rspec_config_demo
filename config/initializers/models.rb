# frozen_string_literal: true
require 'sequel/model'

if ENV['RACK_ENV'] == 'development'
  Sequel::Model.cache_associations = false
end

Sequel::Model.plugin :auto_validations
Sequel::Model.plugin :prepared_statements
Sequel::Model.plugin :require_valid_schema
Sequel::Model.plugin :subclasses unless ENV['RACK_ENV'] == 'development'
Sequel::Model.plugin :validation_helpers
Sequel::Model.plugin :timestamps, update_on_create: true

Sequel.default_timezone = :utc

unless defined?(Unreloader)
  require 'rack/unreloader'
  Unreloader = Rack::Unreloader.new(reload: false)
end

Unreloader.require('app/models'){|f| Sequel::Model.send(:camelize, File.basename(f).delete_suffix('.rb'))}

if %w'development test'.include?(ENV['RACK_ENV'])
  require 'logger'
  LOGGER = Logger.new($stdout)
  LOGGER.level = Logger::FATAL if ENV['RACK_ENV'] == 'test'
  DB.loggers << LOGGER
end

unless ENV['RACK_ENV'] == 'development'
  Sequel::Model.freeze_descendents
end
