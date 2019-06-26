class MenuItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  attribute :price do
    object.price / 100.0
  end
end
