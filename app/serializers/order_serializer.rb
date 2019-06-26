# app/serializers/order_serializer.rb
class OrderSerializer < ActiveModel::Serializer
  attributes :id, :restaurant_id, :complete
  attribute :total_price do
    object.total_price ? object.total_price / 100.0 : 0.0
  end

  has_many :order_items, if: -> { scope && scope[:include_order_items] }
end
