# app/controllers/order_items_controller.rb
class OrderItemsController < ApplicationController
  before_action :authenticate_user!
  # load_and_authorize_resource

  def index
    @order_items = OrderItem.all
    render json: { status: { code: 200, message: 'Success' }, data: @order_items }
  end

  def show
    @order_item = OrderItem.find(params[:id])
    render json: { status: { code: 200, message: 'Success' }, data: @order_item }
  end

  def create
    @order_item = Order.order_items.create(order_item_params)
 
    if @order_item.save
      render json: { status: { code: 200, message: 'Order item created successfully' }, data: @order_item }
    else
      render json: { status: { code: 422, message: 'Order item creation failed', errors: @order_item.errors.full_messages } }
    end
  end

  def update
    @order_item = OrderItem.find(params[:id])

    if @order_item.update(order_item_params)
      render json: { status: { code: 200, message: 'Order item updated successfully' }, data: @order_item }
    else
      render json: { status: { code: 422, message: 'Order item update failed', errors: @order_item.errors.full_messages } }
    end
  end

  def destroy
    @order_item = OrderItem.find(params[:id])
    @order_item.destroy
    render json: { status: { code: 200, message: 'Order item deleted successfully' } }
  end

  private

  def order_item_params
    params.require(:order_item).permit(:order_id, :menu_id, :quantity, :total_price)
  end
end
