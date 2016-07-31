ENV['RACK_ENV'] = 'test'

require "rspec/its"
require "webmock/rspec"
require "dotenv"
require "database_cleaner"
require "factory_girl"
require_relative "factories/check_in"

Dotenv.load(File.expand_path("../../dummy-env", __FILE__))

require_relative "../app/app"

RSpec.configure do |config|
  config.mock_with(:rspec) { |mocks| mocks.verify_partial_doubles = true }
  config.raise_errors_for_deprecations!

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

WebMock.disable_net_connect!

FactoryGirl.allow_class_lookup = false

def app
  WhereIsGrey
end

def fixture_path(filename)
  File.join(File.dirname(__FILE__), "fixtures", filename)
end

def load_fixture(filename)
  File.read(fixture_path(filename))
end
