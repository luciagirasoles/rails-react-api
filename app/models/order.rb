# app/models/order.rb
class Order < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  has_many :order_items
  accepts_nested_attributes_for :order_items
end
