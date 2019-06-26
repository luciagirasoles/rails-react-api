# app/models/restaurant.rb
class Restaurant < ApplicationRecord
  validates :name, :address, :latitud, :longitud, :price_type, presence: true
  validates :price_type, inclusion: { in: %w(low medium expensive) }

  has_one_attached :image
  has_many :menu_items
end
