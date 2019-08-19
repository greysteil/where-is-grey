class FlagRouteDiscontinuities < ActiveRecord::Migration[5.0]
  def change
    add_column :check_ins, :last_before_discontinuity, :boolean, default: false, null: false
  end
end
