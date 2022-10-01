# frozen_string_literal: true

desc "give the application an appropriate name"
task :setup, [:name] do |t, args|
  unless name = args[:name]
    $stderr.puts "ERROR: Must provide a name argument: example: rake \"setup[AppName]\""
    exit(1)
  end

  require 'securerandom'
  require 'fileutils'
  lower_name = name.gsub(/([a-z\d])([A-Z])/, '\1_\2').downcase
  upper_name = lower_name.upcase
  random_bytes = lambda{[SecureRandom.random_bytes(64).gsub("\x00"){((rand*255).to_i+1).chr}].pack('m').inspect}

  File.write('.env.rb', <<END)
# frozen_string_literal: true
case ENV['RACK_ENV'] ||= 'development'
when 'test'
  ENV['#{upper_name}_SESSION_SECRET'] ||= #{random_bytes.call}.unpack('m')[0]
  ENV['#{upper_name}_DATABASE_URL'] ||= "postgres://user:password@127.0.0.1:5432/#{lower_name}_test"
  ENV['APP_DATABASE_URL'] ||= "
when 'production'
  ENV['#{upper_name}_SESSION_SECRET'] ||= #{random_bytes.call}.unpack('m')[0]
  ENV['#{upper_name}_DATABASE_URL'] ||= "postgres://user:password@127.0.0.1:5432/#{lower_name}_production"
else
  ENV['#{upper_name}_SESSION_SECRET'] ||= #{random_bytes.call}.unpack('m')[0]
  ENV['#{upper_name}_DATABASE_URL'] ||= "postgres://user:password@127.0.0.1:5432/#{lower_name}_development"
end
END

  %w'config.ru app/routes/api/v1/health.rb config/application.rb config/db.rb spec/web/spec_helper.rb spec/web/api/v1/health_spec.rb'.each do |f|
    File.write(f, File.read(f).gsub('App', name).gsub('APP', upper_name))
  end

  File.write(__FILE__, File.read(__FILE__).split("\n")[0...(last_line-2)].join("\n") << "\n")
  File.write('.gitignore', "/.env.rb\n")
  FileUtils.remove_dir('.github')
end

# Migrate

migrate = lambda do |env, version|
  ENV['RACK_ENV'] = env
  begin
    require_relative '.env.rb'
  rescue LoadError
  end
  require 'config'
  require_relative 'config/initializers/config'
  require_relative 'config/initializers/db'
  require 'logger'
  Sequel.extension :migration
  DB.loggers << Logger.new($stdout) if DB.loggers.empty?
  Sequel::Migrator.apply(DB, 'db/migrations', version)
end

seeds = lambda do |env|
  ENV['RACK_ENV'] = env
  begin
    require_relative '.env.rb'
  rescue LoadError
  end
  require 'config'
  require_relative 'config/initializers/config'
  require_relative 'config/initializers/db'
  require_relative 'config/initializers/models'
  require 'logger'
  require_relative 'db/seeds'
end

dump_schema = lambda do 
  schema = DB.dump_schema_migration
  body = '# Version: ' + Time.now.strftime("%Y%m%d%H%M%S\n") + schema
  File.open("db/schema.rb", 'w') {|f| f.write(body) }
end

desc "Migrate test database to latest version"
task :test_up do
  migrate.call('test', nil)
  dump_schema.call()
end

desc "Migrate test database all the way down"
task :test_down do
  migrate.call('test', 0)
  dump_schema.call()
end

desc "Migrate test database all the way down and then back up"
task :test_bounce do
  migrate.call('test', 0)
  Sequel::Migrator.apply(DB, 'db/migrations')
  dump_schema.call()
end

desc "Migrate development database to latest version"
task :dev_up do
  migrate.call('development', nil)
  dump_schema.call()
end

desc "Migrate development database to all the way down"
task :dev_down do
  migrate.call('development', 0)
  dump_schema.call()
end

desc "Migrate development database all the way down and then back up"
task :dev_bounce do
  migrate.call('development', 0)
  Sequel::Migrator.apply(DB, 'db/migrations')
  dump_schema.call()
end

desc "Migrate production database to latest version"
task :prod_up do
  migrate.call('production', nil)
end

desc "Migrate production database to all the way down"
task :prod_down do
  migrate.call('production', 0)
  dump_schema.call()
end

desc "Seed test database"
task :test_seed do
  seeds.call('test')
end

desc "Seed development database"
task :dev_seed do
  seeds.call('development')
end

desc "Seed production database"
task :prod_seed do
  seeds.call('production')
end
