require 'sinatra'
require 'redis-sinatra'
require "sinatra/activerecord"
require_relative 'models/application_record'
require_relative 'models/check_in'

require 'prius'
require 'spot'
require 'dotenv' if development?

Dotenv.load if development?
Prius.load(:google_public_api_key)
Prius.load(:spot_feed_id)
Prius.load(:spot_feed_password, required: false)
Prius.load(:redis_url)

class WhereIsGrey < Sinatra::Base
  register Sinatra::Cache
  register Sinatra::ActiveRecordExtension

  set :public_folder, Proc.new { File.join(root, "static") }
  set :static, true
  set :static_cache_control, [:public, max_age: 300]
  set :database_file, File.expand_path("../../config/database.yml", __FILE__)

  get '/' do
    erb :index,
        locals: {
          api_key: google_public_api_key,
          latest_check_in: latest_check_in
        }
  end

  private

  def google_public_api_key
    Prius.get(:google_public_api_key)
  end

  def latest_check_in
    settings.cache.fetch(:latest_spot_check_in, expire_in: 300) do
      spot_client.messages.latest
    end
  end

  def spot_client
    @spot_client ||=
      SPOT::Client.new(
        feed_id: Prius.get(:spot_feed_id),
        feed_password: Prius.get(:spot_feed_password)
      )
  end
end
