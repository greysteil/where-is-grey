require 'sinatra'
require 'prius'
require 'spot'
require 'dotenv' if development?

Dotenv.load if development?
Prius.load(:google_public_api_key)
Prius.load(:spot_feed_id)
Prius.load(:spot_feed_password, required: false)

class WhereIsGrey < Sinatra::Base
  set :public_folder, Proc.new { File.join(root, "static") }
  set :static, true
  set :static_cache_control, [:public, max_age: 300]

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
    spot_client.messages.latest
  end

  def spot_client
    @spot_client ||=
      SPOT::Client.new(
        feed_id: Prius.get(:spot_feed_id),
        feed_password: Prius.get(:spot_feed_password)
      )
  end
end
