# frozen_string_literal: true

module Orders
  module Processor
    class Discount
      include Base

      def execute!
        apply_discount_on_order_items!
        apply_discount_on_order!

        { order: @order, order_items: @order_items }
      end

      def apply_discount_on_order!
        @order[:discount] = calculate(:discount, @order_items)
      end

      def apply_discount_on_order_items!
        @order_items.each do |order_item|
          apply_discount_to_order_item(order_item)
        end
      end

      def apply_discount_to_order_item(order_item)
        discount = find_best_discount(order_item)
        return if discount.nil?

        @order_items
          .select { |oi| oi[:item].id == discount[:order_item][:item].id }
          .map! { |oi| oi.merge!(discount: discount[:discount_price]) }
      end

      def find_best_discount(order_item)
        discount_price = 0
        remaining_quantity = order_item[:quantity] 
        order_item[:item]
          .all_discounts
          .map { |discount| calculate_discount_for_order_item(discount, order_item) }
          .sort_by { |discount| -discount[:discount_price] } # Apply maximum discount first
          .each do |discount|
            return { order_item:, discount_price: } if remaining_quantity < 1

            discount_quantity_to_apply = [remaining_quantity, discount[:quantity]].min
            discount_price += discount[:discount_price] * discount_quantity_to_apply
            remaining_quantity -= discount_quantity_to_apply
          end

        { order_item:, discount_price: }
      end

      def calculate_discount_for_order_item(discount, order_item)
        if discount.apply_on_associated_item?
          item = find_order_item(discount.item)
          return no_discount_applied if item.nil?

          quantity_to_apply = [item[:quantity], order_item[:quantity]].min
        else
          quantity_to_apply = order_item[:quantity]
        end

        discount_price = discount.calculate_discount(item_price(order_item))

        { discount_price: discount_price, quantity: quantity_to_apply }
      end

      def no_discount_applied
        { discount_price: 0, quantity: 0 }
      end

      def find_order_item(item)
        @order_items.find { |oi| oi[:item].id == item.id }
      end

      def item_price(order_item)
        order_item[:item].price
      end
    end
  end
end
