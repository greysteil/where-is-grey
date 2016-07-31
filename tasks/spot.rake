require 'prius'
require 'spot'
require_relative "../app/app"

if ENV['RACK_ENV'].nil? || ENV['RACK_ENV'].to_sym == :development
  require 'dotenv'
  Dotenv.load
end

Prius.load(:spot_feed_id)
Prius.load(:spot_feed_password, required: false)

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

namespace :spot do
  desc 'Gets latest SPOT messages for SPOT_FEED_ID and stores them'
  task :fetch_latest_messages do
    spot_client.messages.all.each do |message|
      next if CheckIn.exists?(spot_id: message.id)

      CheckIn.create!(
        spot_id: message.id,
        sent_at: message.created_at,
        latitude: message.latitude,
        longitude: message.longitude,
        battery_state: message.battery_state,
        message_type: message.type
      )
    end
  end
end
