# frozen_string_literal: true

module Orders
  module Processor
    class Payable
      include Base

      def execute!
        calculate_payable_on_order_items!
        calculate_payable_on_order!

        { order:, order_items: }
      end

      def calculate_payable_on_order!
        @order[:payable] = calculate(:payable, order_items)
      end

      def calculate_payable_on_order_items!
        @order_items
          .map! { |order_item|  order_item.merge({payable: calculate_payable(order_item)}) }
      end

      def calculate_payable(order_item)
        order_item[:price].to_f + order_item[:taxable_amount].to_f - order_item[:discount].to_f
      end
    end
  end
end
