FactoryBot.define do
  factory :photo do
    latitude               { 61.54875 }
    longitude              { -3.0697 }
    url                    { "https://example.com/image.jpeg" }
    taken_at               { Time.now }
    sequence(:external_id) { |n| "external-id-#{n}" }
  end
end
