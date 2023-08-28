# frozen_string_literal: true

module Orders
  module Serializers
    class OrderSerializer
      include Utils::OrderItemCalculation

      attr_accessor :customer_name, :customer_contact, :line_items, :order_type

      def self.call!(data)
        new(data).serialize!
      end

      def initialize(params = {})
        @line_items       = params[:order_items_attributes]
        @order_type       = params[:order_type]
        @customer_name    = params[:customer_name]
        @customer_contact = params[:customer_contact]
      end

      def serialize!
        order_items = serialized_order_items
        order       = serialized_order(order_items)

        { order:, order_items: }
      end

      def serialized_order(order_items)
        {
          order_type:,
          customer_name:,
          customer_contact:,
          price: calculate(:price, order_items)
        }
      end

      def serialized_order_items
        line_item_array = []
        Array.wrap(line_items).each do |line_item|
          line_item_array << OrderItemSerializer.call!(line_item)
        end

        line_item_array.compact
      end

      def calculate(column_name, order_items)
        order_items.sum { |order_item| order_item[column_name] }
      end
    end
  end
end
