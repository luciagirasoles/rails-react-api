# app/serializers/menu_item_serializer.rb
class MenuItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :estimated_time
  attribute :price do
    object.price / 100.0
  end
end
