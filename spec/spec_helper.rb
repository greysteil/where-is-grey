ENV["RACK_ENV"] = "test"

require "rspec/its"
require "webmock/rspec"
require "dotenv"

Dotenv.load(File.expand_path("../../dummy-env", __FILE__))

require_relative "../app/app"

WebMock.disable_net_connect!

RSpec.configure do |config|
  config.mock_with(:rspec) { |mocks| mocks.verify_partial_doubles = true }
  config.raise_errors_for_deprecations!
end

def app
  WhereIsGrey
end

def fixture_path(filename)
  File.join(File.dirname(__FILE__), "fixtures", filename)
end

def load_fixture(filename)
  File.read(fixture_path(filename))
end
