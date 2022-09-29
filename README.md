# RodaSequelRspecConfig
Application skeleton based on Roda

RodaSequelRspecConfig is a Rails-like application skeleton for an app using Roda as the web framework, Sequel as the database library, Rspec as test suite, and is configured using [Config](https://github.com/rubyconfig/config).

It's set up so you can clone this repository and base your application on it:
```bash
$ git clone git@github.com:Oreol-Group/roda_sequel_rspec_config.git my_app && cd my_app && rake "setup[MyApp]"
```
## Database Setup
By default Sequel assumes a PostgreSQL database, with an application specific PostgreSQL database account.  You can create this via:
```bash
$ createuser -U postgres my_app
$ createdb -U postgres -O my_app my_app_production
$ createdb -U postgres -O my_app my_app_test
$ createdb -U postgres -O my_app my_app_development
```
Create password for user account via:
```bash
$ sudo su - postgres
$ psql -c "alter user my_app with password 'mypassword'"
```
Configure the database connection defined in .env.rb for the ENV parameter `ENV['MY_APP_DATABASE_URL'] ||= "postgres://user:password@host:port/database_name_environment"` like so:
```ruby
case ENV['RACK_ENV'] ||= 'development'
when 'test'
  ENV['MY_APP_DATABASE_URL'] ||= "postgres://my_app:mypassword@127.0.0.1:5432/my_app_test"
when 'production'
  ENV['MY_APP_DATABASE_URL'] ||= "postgres://my_app:mypassword@127.0.0.1:5432/my_app_production"
else
  ENV['MY_APP_DATABASE_URL'] ||= "postgres://my_app:mypassword@127.0.0.1:5432/my_app_development"
end
```
## Environment setup
```bash
$ bundle install
```
## Run App
Either set up configuration into `config/initializers/config.rb`, `config/settings/*.yml` and `config/*.yml` before running

```bash
$ bin/puma
$ bin/console
```
or run the application with modified configuration using environment variables
```bash
$ RACK_ENV=test ENV__PAGINATION__PAGE_SIZE=100 bin/puma
$ RACK_ENV=test ENV__PAGINATION__PAGE_SIZE=100 bin/console
```
## HTTP-requests to the app
```
$ curl --url "http://localhost:9292" -v
$ http :9292
```
### Author
* it.Architect https://github.com/Oreol-Group/roda_sequel_rspec_config
* Inspired by [Jeremy Evans](https://github.com/jeremyevans/roda-sequel-stack) and [Evgeniy Fateev](https://github.com/psylone/ads-microservice)
