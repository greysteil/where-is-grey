check_in_list = [
  {
    message_type: 'TRACK',
    spot_id: 123,
    sent_at: Date.parse('2016-01-01'),
    latitude: 61.54875,
    longitude: -3.0697,
    battery_state: 'GOOD'
  },
  {
    message_type: 'TRACK',
    spot_id: 124,
    sent_at: Date.parse('2016-01-02'),
    latitude: 62.54875,
    longitude: -3.0697,
    battery_state: 'GOOD'
  },
  {
    message_type: 'TRACK',
    spot_id: 125,
    sent_at: Date.parse('2016-01-03'),
    latitude: 62.54875,
    longitude: -2.0697,
    battery_state: 'GOOD'
  },
  {
    message_type: 'TRACK',
    spot_id: 126,
    sent_at: Date.parse('2016-01-04'),
    latitude: 63.54875,
    longitude: -2.0697,
    battery_state: 'GOOD'
  },
  {
    message_type: 'TRACK',
    spot_id: 127,
    sent_at: Date.parse('2016-01-05'),
    latitude: 63.54875,
    longitude: -1.0697,
    battery_state: 'GOOD'
  },
]

check_in_list.each { |attrs| CheckIn.create(attrs) }
