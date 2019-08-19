class AddTakenAtToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :taken_at, :timestamp, null: false
  end
end
