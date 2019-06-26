# app/models/menu_item.rb
class MenuItem < ApplicationRecord
  belongs_to :restaurant
end
