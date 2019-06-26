# app/serializers/restaurant_serializer.rb
class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :price_type

  attribute :address do
    { name: object.address, latitud: object.latitud, longitud: object.longitud }
  end
end
