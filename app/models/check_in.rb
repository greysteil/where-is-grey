class CheckIn < ApplicationRecord
  validates :message_type, presence: true
  validates :spot_id, presence: true
  validates :sent_at, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :battery_state, presence: true
end
