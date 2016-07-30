require 'active_record'
include ActiveRecord::Tasks

db_dir = File.expand_path('../../db', __FILE__)
config_dir = File.expand_path('../../config', __FILE__)

DatabaseTasks.env = ENV['ENV'] || 'development'
DatabaseTasks.db_dir = db_dir
DatabaseTasks.database_configuration =
  YAML.load_file(File.join(config_dir, 'database.yml')).fetch(DatabaseTasks.env)
DatabaseTasks.migrations_paths = File.join(db_dir, 'migrate')

task :environment do
  ActiveRecord::Base.establish_connection DatabaseTasks.database_configuration
end

load 'active_record/railties/databases.rake'
