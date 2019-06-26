# app/controllers/restaurants_controller.rb
class RestaurantsController < ApplicationController
  resource_description do
    short 'Restaurants'
    formats ['json']
    desc <<-DESC
    Example of response of just restaurant resources

      {
        "id": 3,
        "name": "restaurant example",
        "price_type": "low",
        "address": {
            "name": "Av. sSS 123",
            "latitud": "0.12",
            "longitud": "1.233"
        }
      }

    Example of response of restaurant with menu items resources

      {
        "id": 3,
        "name": "restaurant example",
        "price_type": "low",
        "address": {
            "name": "Av. sSS 123",
            "latitud": "0.12",
            "longitud": "1.233"
        },
        "menu_items": [
            {
                "id": 1,
                "name": "dessert1",
                "description": null,
                "estimated_time": 20,
                "price": 7
            },
            {
                "id": 2,
                "name": "dessert2",
                "description": null,
                "estimated_time": 30,
                "price": 7.5
            }
        ]
      }
    DESC
  end

  def_param_group :restaurant do
    property :id, :number, desc: 'Id of the restaurant'
    property :name, String, desc: 'Name of the restaurant'
    property :price_type, %w[low medium expensive], desc: 'Types of restaurant costs'
    property :address, Hash, 'Details of address' do
      property :name, String, desc: 'Address details'
      property :latitud, :decimal, desc: 'Latitud of address'
      property :longitud, :decimal, desc: 'Longitud of address'
    end
  end

  # action INDEX
  api :GET, '/restaurants', 'List of all the restaurants'

  returns code: :ok, desc: 'List of restaurants' do
    param_group :restaurant
  end

  returns code: :unauthorized, desc: 'Required login' do
    property :errors, Hash, desc: 'Access denied'
  end
  def index
    render json: Restaurant.all
  end

  # action SHOW
  api :GET, '/restaurants/:id', 'Details of restaurant'
  param :id, :number, desc: 'Id of the restaurant'

  returns code: :ok, desc: 'List of restaurants' do
    param_group :restaurant
    property :menu_items, Array, desc: 'List of restaurant\'s menu items' do
      property :id, :number, desc: 'Id of menu item'
      property :name, String, desc: 'Name of menu item'
      property :description, String, desc: 'Description of menu item'
      property :estimated_time, :number, desc: 'Estimated preparation time of menu item, in minutes'
      property :price, :decimal, desc: 'Price of menu item'
    end
  end

  returns code: :unauthorized, desc: 'Required login' do
    property :errors, Hash, desc: 'Access denied'
  end
  def show
    restaurant = Restaurant.find(params[:id])
    render json: restaurant, scope: { action: :show }
  end
end
