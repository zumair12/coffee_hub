# frozen_string_literal: true

class ItemsController < ApplicationController

  def index
    @items = Item.all    
    respond_to do |format|
      format.html # Render HTML template (if needed)
      format.json { render json: @items }
    end
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    respond_to do |format|
      if @item.save
        format.html { redirect_to items_path, notice: "Item was successfully created." }
        format.json { render json: @item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.orders.none? && @item.destroy
        format.html { redirect_to items_path, notice: 'Item deleted successfully.' }
        format.json { render json: { message: 'Item deleted successfully.' }, status: :ok }
      else
        format.html { redirect_to items_path, alert: "Failed to delete item. #{@item.orders.count} attached orders" }
        format.json { render json: { errors: @item.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :tax_rate)
  end
end
