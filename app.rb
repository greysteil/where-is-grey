require 'sinatra'
require "sinatra/reloader" if development?

require "prius"

require "dotenv" if development?
Dotenv.load if development?

Prius.load(:google_public_api_key)

get '/' do
  erb :index, locals: { api_key: Prius.get(:google_public_api_key) }
end
