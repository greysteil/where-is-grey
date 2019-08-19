class AddPhotoDescription < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :description, :text
    add_column :photos, :external_id, :string, null: false
  end
end
