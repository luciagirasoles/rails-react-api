class AddCompleteToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :complete, :boolean, default: false
  end
end
