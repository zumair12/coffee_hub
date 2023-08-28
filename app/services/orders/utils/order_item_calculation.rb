# frozen_string_literal: true

module Orders
  module Utils
    module OrderItemCalculation
      extend self

      def calculate(column_name, order_items)
        order_items.map { |order_item| order_item[column_name] }.compact.sum
      end
    end
  end
end

