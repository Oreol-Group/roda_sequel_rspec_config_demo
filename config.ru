# frozen_string_literal: true

require_relative 'config/environment'

dev = ENV['RACK_ENV'] == 'development'

if dev
  require 'logger'
  logger = Logger.new($stdout)
end

Unreloader = Rack::Unreloader.new(subclasses: %w'Roda Sequel::Model', logger: logger, reload: dev){App}

Unreloader.require('config/application.rb'){'App'}

run(dev ? Unreloader : App.freeze.app)

# # We can write this if we only have one route in our microservice
# map '/api/v1/' do
#   run(dev ? Unreloader : App.freeze.app)
# end
