require 'sinatra'

require "prius"

require "dotenv" if development?
Dotenv.load if development?

Prius.load(:google_public_api_key)

set :public_folder, Proc.new { File.join(root, "static") }
set :static, true

get '/' do
  erb :index, locals: { api_key: Prius.get(:google_public_api_key) }
end
