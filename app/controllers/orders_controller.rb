# frozen_string_literal: true

class OrdersController < ApplicationController

  def index
    @pagy, @orders = pagy(Order.order(id: :desc).all, items: 10)
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items    
  end

  def new
    @order = Order.new
    @items = Item.all
  end

  def create
    @items = Item.all
    @order = Orders::OrderService.placeOrder(order_params)

    respond_to do |format|
      if @order.persisted?
        @order.scheduled_jobs

        format.html { redirect_to orders_path, notice: "Order was successfully created." }
        format.json { render json: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.destroy
        format.html { redirect_to orders_path, notice: 'Order deleted successfully.' }
        format.json { render json: { message: 'Order deleted successfully.' }, status: :ok }
      else
        format.html { redirect_to orders_path, alert: "Failed to delete order." }
        format.json { render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  private

  def order_params
    params.require(:order).permit(:customer_name, :customer_contact, :order_type, order_items_attributes: [:quantity, :item_id])
  end
end
