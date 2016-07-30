require 'active_record'
require 'yaml'

class ActiveRecordInitializer
  def run
    require_database_yml
    configure_active_record
  end

  private

  def config_path
    File.expand_path("../../database.yml", __FILE__)
  end

  def config
    YAML.load_file(config_path).fetch(ENV['RACK_ENV'].to_s)
  end

  def configure_active_record
    ActiveRecord::Base.establish_connection(config)
  end

  def require_database_yml
    unless File.exists?(config_path)
      raise "Database config file was not found at #{config_path}"
    end
  end
end
