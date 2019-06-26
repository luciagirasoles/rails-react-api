# app/controllers/orders_controller.rb
class OrdersController < ApplicationController
  def index
    render json: current_user.orders
  end

  def show
    order = Order.find(params[:id])
    if order.user == current_user
      render json: order
    else
      render_unauthorized('Access denied')
    end
  end

  def create
    order = Order.new(order_params)
    order.user = current_user
    if order.save
      render json: order, include: :order_items
    else
      render json: order.errors.full_messages, status: :bad_request
    end
  end

  private

  def order_params
    params.require(:order).permit(
      :restaurant_id, order_items_attributes: %I[menu_item_id quantity]
    )
  end
end
