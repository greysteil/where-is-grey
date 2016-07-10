ENV["RACK_ENV"] = "test"

require "rspec/its"
require "dotenv"

Dotenv.load(File.expand_path("../../dummy-env", __FILE__))

require_relative "../app/app"

RSpec.configure do |config|
  config.mock_with(:rspec) { |mocks| mocks.verify_partial_doubles = true }
  config.raise_errors_for_deprecations!
end

def app
  WhereIsGrey
end
