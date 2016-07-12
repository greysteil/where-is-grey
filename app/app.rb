require 'sinatra'
require "prius"
require "dotenv" if development?

Dotenv.load if development?
Prius.load(:google_public_api_key)

class WhereIsGrey < Sinatra::Base
  set :public_folder, Proc.new { File.join(root, "static") }
  set :static, true
  set :static_cache_control, [:public, max_age: 300]

  get '/' do
    erb :index, locals: { api_key: google_public_api_key }
  end

  private

  def google_public_api_key
    Prius.get(:google_public_api_key)
  end
end
