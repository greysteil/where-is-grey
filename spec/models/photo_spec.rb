require_relative "../spec_helper"

RSpec.describe Photo, type: :model do
  subject(:photo) { FactoryBot.build(:photo) }

  it { is_expected.to be_valid }

  context "without a latitude" do
    before { photo.latitude = nil }
    it { is_expected.to_not be_valid }
  end

  context "without a longitude" do
    before { photo.longitude = nil }
    it { is_expected.to_not be_valid }
  end

  context "without a url" do
    before { photo.url = nil }
    it { is_expected.to_not be_valid }
  end

  context "without a taken_at" do
    before { photo.taken_at = nil }
    it { is_expected.to_not be_valid }
  end

  context "without an external_id" do
    before { photo.external_id = nil }
    it { is_expected.to_not be_valid }
  end
end
