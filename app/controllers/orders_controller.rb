# app/controllers/orders_controller.rb
class OrdersController < ApplicationController
  resource_description do
    short 'Orders'
    formats ['json']
    desc <<-DESC
    Example of params to create an order with order items
      {
        "order": {
          "restaurant_id": 3,
          "order_items_attributes": [
            {
              "menu_item_id": 1,
              "quantity": 3
            },
            {
              "menu_item_id": 2,
              "quantity": 5
            }
          ]
        }
      }

    Example of response an order without order_items
      {
        "id": 3,
        "restaurant_id": 3,
        "complete": false,
        "total_price": 0
      }

    Example of response an order with order_items
      {
        "id": 3,
        "restaurant_id": 3,
        "complete": false,
        "total_price": 0,
        "order_items": [
            {
                "id": 3,
                "menu_item_id": 1,
                "quantity": 3
            },
            {
                "id": 4,
                "menu_item_id": 2,
                "quantity": 5
            }
        ]
      }
    DESC
  end

  def_param_group :order do
    property :id, :number, desc: 'Id of the order'
    param :restaurant_id, Integer, desc: 'If of restaurant which was ordered'
    property :complete, [true, false], desc: 'Status of the order'
    property :total_price, :decimal, desc: 'Total price of the order'
  end

  def_param_group :order_item do
    property :id, :number, desc: 'Id of the order item, only in response'
    param :menu_item_id, :number, desc: 'If of the selected menu item'
    param :quantity, :number, desc: 'Quantity of selected menu items'
  end

  # action INDEX
  api :GET, '/orders', 'List of orders of logged in user'

  returns code: :ok, desc: 'List of orders' do
    param_group :order
  end

  returns code: :unauthorized, desc: 'Required login' do
    property :errors, Hash, desc: 'Access denied'
  end
  def index
    render json: current_user.orders
  end

  # action SHOW
  api :GET, '/orders/:id', 'Details of order, includes order_items'
  param :id, :number, desc: 'Id of the order'
  returns code: :ok, desc: 'Details of order' do
    param_group :order
    property :order_items, array_of: Hash do
      param_group :order_item
    end
  end

  returns code: :unauthorized, desc: 'Required login or is not an order of the current user' do
    property :errors, Hash, desc: 'Access denied'
  end
  def show
    order = Order.find(params[:id])
    if order.user == current_user
      render json: order, scope: { include_order_items: true }
    else
      render_unauthorized('Access denied')
    end
  end

  # action CREATE
  api :POST, '/orders', 'Create a new order'

  param_group :order
  param :order_items_attributes, Array, desc: 'Order items' do
    param_group :order_item, OrdersController
  end

  returns code: :ok, desc: 'Details of order' do
    param_group :order
    property :order_items, array_of: Hash do
      param_group :order_item
    end
  end

  returns code: :bad_request, desc: 'Valid attributes needed' do
    property :errors, Array, desc: 'List of validation errors'
  end

  returns code: :unauthorized, desc: 'Required login' do
    property :errors, Hash, desc: 'Access denied'
  end
  def create
    order = Order.new(order_params)
    order.user = current_user
    if order.save
      render json: order, scope: { include_order_items: true }
    else
      errors = { errors: order.errors.full_messages }
      render json: errors, status: :bad_request
    end
  end

  # action UPDATE
  api :PUT, '/orders/:id', 'Mark as complete an order'
  param :id, :number, desc: 'Id of the order'

  returns code: :ok, desc: 'Details of order' do
    param_group :order
    property :order_items, array_of: Hash do
      param_group :order_item
    end
  end

  returns code: :unauthorized, desc: 'Required login or is not an order of the current user' do
    property :errors, Hash, desc: 'Access denied'
  end
  def update
    order = Order.find(params[:id])
    if order.user == current_user
      order.update(complete: true)
      render json: order
    else
      render_unauthorized('Access denied')
    end
  end

  private

  def order_params
    params.require(:order).permit(
      :restaurant_id, order_items_attributes: %I[menu_item_id quantity]
    )
  end
end
