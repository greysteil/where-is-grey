class AddPhotosTable < ActiveRecord::Migration
  def up
    create_table :photos do |t|
      t.decimal :latitude, null: false, precision: 16, scale: 6
      t.decimal :longitude, null: false, precision: 16, scale: 6
      t.string :url, null: false
      t.timestamps null: false
    end

    add_index :photos, :url, unique: true
  end

  def down
    drop_table :photos
  end
end

