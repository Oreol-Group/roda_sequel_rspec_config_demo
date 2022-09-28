# RodaSequelRspecConfig
application skeleton based on Roda

RodaSequelRspecConfig is a Rails-like application skeleton for an app using Roda as the web framework, Sequel as the database library, Rspec as test suite, and is configured using [Config](https://github.com/rubyconfig/config).

It's set up so you can clone this repository and base your application on it:
```
git clone git@github.com:Oreol-Group/roda_sequel_rspec_config.git my_app && cd my_app
```

## Database Setup
By default Sequel assumes a PostgreSQL database, with an application specific PostgreSQL database account.  You can create this via:
```bash
$ createuser -U postgres my_app
$ createdb -U postgres -O my_app my_app_production
$ createdb -U postgres -O my_app my_app_test
  createdb -U postgres -O my_app my_app_development
```
Database connection should be defined in .env.rb.
```bash
$ touch .env.rb
$ subl .env.rb
```
```ruby
case ENV['RACK_ENV'] ||= 'development'
when 'test'
  ENV['MY_APP_DATABASE_URL'] ||= "postgres://user:password@host:port/test_database_name"
when 'production'
  ENV['MY_APP_DATABASE_URL'] ||= "postgres://user:password@host:port/production_database_name"
else
  ENV['MY_APP_DATABASE_URL'] ||= "postgres://user:password@host:port/development_database_name"
end
```
## Environment setup
```bash
$ bundle install
```

### Author
* it.Architect https://github.com/Oreol-Group/roda_sequel_rspec_config
* Inspired by [Jeremy Evans](https://github.com/jeremyevans/roda-sequel-stack) and [Evgeniy Fateev](https://github.com/psylone/ads-microservice)
