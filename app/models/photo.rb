class Photo < ApplicationRecord
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :url, presence: true
  validates :taken_at, presence: true
  validates :external_id, presence: true

  def thumbnail_url
    url.gsub(/\.jpeg/, '_t.jpeg')
  end
end
