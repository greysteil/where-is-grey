require 'net/http'
require 'prius'

if ENV['RACK_ENV'].nil? || ENV['RACK_ENV'].to_sym == :development
  require 'dotenv'
  Dotenv.load
end

desc 'Pings PING_URL to keep a dyno alive'
task :dyno_ping do
  Prius.load(:ping_url)

  uri = URI(Prius.get(:ping_url))
  Net::HTTP.get_response(uri)
end
