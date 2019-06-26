# app/controllers/restaurants_controller.rb
class RestaurantsController < ApplicationController
  def index
    render json: Restaurant.all
  end

  def show
    restaurant = Restaurant.find(params[:id])
    render json: restaurant, scope: { action: :show }
  end
end
