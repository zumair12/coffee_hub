# frozen_string_literal: true

class DiscountsController < ApplicationController

  def index
    @discounts = Discount.all    
    respond_to do |format|
      format.html # Render HTML template (if needed)
      format.json { render json: @discounts }
    end
  end

  def new
    @discount = Discount.new
  end

  def create
    @discount = Discount.new(discount_params)
    respond_to do |format|
      if @discount.save
        format.html { redirect_to discounts_path, notice: "Discount was successfully created." }
        format.json { render json: @discount }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @discount.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @discount = Discount.find(params[:id])

    respond_to do |format|
      if @discount.destroy
        format.html { redirect_to discounts_path, notice: 'Discount deleted successfully.' }
        format.json { render json: { message: 'Discount deleted successfully.' }, status: :ok }
      else
        format.html { redirect_to discounts_path, alert: "Failed to delete Discount." }
        format.json { render json: { errors: @discount.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  private

  def discount_params
    params.require(:discount).permit(:item_id, :applicable_item_id, :discount_rate, :cap_amount)
  end
end
