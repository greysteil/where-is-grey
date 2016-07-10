require_relative "spec_helper"
require "rack/test"

describe WhereIsGrey do
  include Rack::Test::Methods

  describe "/" do
    subject(:index) { get "/" }
    its(:status) { is_expected.to eq(200) }
  end
end
