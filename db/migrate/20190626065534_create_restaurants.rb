class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.decimal :latitud
      t.decimal :longitud
      t.string :price_type
      t.string :ranking

      t.timestamps
    end
  end
end
