class CreateCheckInsTable < ActiveRecord::Migration[5.0]
  def up
    create_table :check_ins do |t|
      t.string :message_type, null: false
      t.string :spot_id, null: false
      t.datetime :sent_at, null: false
      t.decimal :latitude, null: false, precision: 16, scale: 6
      t.decimal :longitude, null: false, precision: 16, scale: 6
      t.string :battery_state, null: false
      t.timestamps null: false
    end

    add_index :check_ins, :spot_id, unique: true
  end

  def down
    drop_table :check_ins
  end
end

