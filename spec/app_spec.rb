require_relative "spec_helper"
require "rack/test"

RSpec.describe WhereIsGrey do
  include Rack::Test::Methods

  describe "/" do
    subject(:index) { get "/" }

    context "with a recent check in" do
      let!(:latest_check_in) { FactoryBot.create(:check_in) }

      its(:status) { is_expected.to eq(200) }
      its(:body) { is_expected.to include(latest_check_in.latitude.to_s) }
    end

    context "with no recent check ins" do
      its(:status) { is_expected.to eq(200) }
    end
  end
end
