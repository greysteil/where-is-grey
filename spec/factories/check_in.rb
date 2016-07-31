FactoryGirl.define do
  factory :check_in do
    battery_state "good"
    message_type "OK"
    latitude 61.54875
    longitude -3.0697
    spot_id "585079373"
    sent_at { Time.now }
  end
end
