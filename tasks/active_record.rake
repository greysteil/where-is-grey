require "sinatra/activerecord/rake"

ActiveRecord.schema_format = :sql

namespace :db do
  task :load_config do
    require_relative "../app/app"
  end
end
