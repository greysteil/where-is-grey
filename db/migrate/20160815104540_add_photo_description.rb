class AddPhotoDescription < ActiveRecord::Migration
  def change
    add_column :photos, :description, :text
    add_column :photos, :external_id, :string, null: false
  end
end
