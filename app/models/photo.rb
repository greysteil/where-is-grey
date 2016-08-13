class Photo < ApplicationRecord
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :url, presence: true
end
