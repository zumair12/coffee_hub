# frozen_string_literal: true

module Orders
  module Processor
    class Tax
      include Base

      def execute!
        apply_tax_on_order_items!
        apply_tax_on_order!

        { order:, order_items: }
      end

      def apply_tax_on_order!
        @order[:taxable_amount] = calculate(:taxable_amount, order_items)
      end

      def apply_tax_on_order_items!
        @order_items
          .map! { |order_item|  order_item.merge({taxable_amount: calculate_tax(order_item)}) }
      end

      # I assume tax on price without discount
      def calculate_tax(order_item)
        (order_item[:price] * order_item[:item].tax_rate) / 100
      end
    end
  end
end
