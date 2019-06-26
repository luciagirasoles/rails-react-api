class Restaurant < ApplicationRecord
  has_one_attached :image
  validates :name, :address, :latitud, :longitud, :price_type, presence: true
  validates :price_type, inclusion: { in: %w(low medium expensive) }
end
