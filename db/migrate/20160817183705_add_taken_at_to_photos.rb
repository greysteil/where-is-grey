class AddTakenAtToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :taken_at, :timestamp, null: false
  end
end
