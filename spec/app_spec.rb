require_relative "spec_helper"
require "rack/test"
require 'pry'

describe WhereIsGrey do
  include Rack::Test::Methods

  before do
    spot_latest_url = SPOT.endpoint + Prius.get(:spot_feed_id) + '/latest.json'
    stub_request(:get, spot_latest_url).to_return(
      body: load_fixture('spot_latest.json'),
      headers: { 'Content-Type' => 'application/json' }
    )
  end

  describe "/" do
    subject(:index) { get "/" }
    its(:status) { is_expected.to eq(200) }
    its(:body) { is_expected.to include("61.54875") }
  end
end
