class CreateCheckInsTable < ActiveRecord::Migration
  def up
    create_table :check_ins do |t|
      t.string :message_type, null: false
      t.datetime :spot_id, null: false
      t.datetime :sent_at, null: false
      t.decimal :latitude, null: false, precision: 16, scale: 6
      t.decimal :longitude, null: false, precision: 16, scale: 6
      t.string :battery_state, null: false
      t.timestamps null: false
    end
  end

  def down
    drop_table :check_ins
  end
end

