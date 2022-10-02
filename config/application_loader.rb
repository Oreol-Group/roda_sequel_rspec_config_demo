# frozen_string_literal: true

module ApplicationLoader
  extend self

  def load_app!
    init_config
    init_db
    require_app
    init_app
  end

  def root
    @@root ||= File.expand_path('..', __dir__)
  end

  private

  def init_config
    require_file 'config/initializers/config'
  end

  def init_db
    require_file 'config/initializers/db'
    require_file 'config/initializers/models'
  end

  def require_app
    require_dir 'config/initializers'
    Unreloader.require(File.join(self.root, 'app/contracts'))
    Unreloader.require(File.join(self.root, 'app/services'))
  end

  def init_app
    require_dir 'config/initializers'
  end

  def require_file(path)
    require File.join(self.root, path)
  end

  def require_dir(path)
    path = File.join(self.root, path)
    Dir["#{path}/**/*.rb"].each { |file| require file }
  end
end
