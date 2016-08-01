class FlagRouteDiscontinuities < ActiveRecord::Migration
  def change
    add_column :check_ins, :last_before_discontinuity, :boolean, default: false, null: false
  end
end
