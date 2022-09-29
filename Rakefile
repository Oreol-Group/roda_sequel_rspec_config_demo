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
