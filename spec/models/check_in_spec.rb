require_relative "../spec_helper"

RSpec.describe CheckIn, type: :model do
  subject(:check_in) { FactoryBot.build(:check_in) }

  it { is_expected.to be_valid }

  context "without a spot_id" do
    before { check_in.spot_id = nil }
    it { is_expected.to_not be_valid }
  end

  context "without a latitude" do
    before { check_in.latitude = nil }
    it { is_expected.to_not be_valid }
  end

  context "without a longitude" do
    before { check_in.longitude = nil }
    it { is_expected.to_not be_valid }
  end

  context "without a sent_at" do
    before { check_in.sent_at = nil }
    it { is_expected.to_not be_valid }
  end
end
