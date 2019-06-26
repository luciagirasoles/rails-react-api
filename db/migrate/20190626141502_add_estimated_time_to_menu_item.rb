class AddEstimatedTimeToMenuItem < ActiveRecord::Migration[5.2]
  def change
    add_column :menu_items, :estimated_time, :integer
  end
end
