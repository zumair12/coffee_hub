# frozen_string_literal: true
module Orders
  module Serializers
    class OrderItemSerializer
      attr_accessor :item, :quantity

      def self.call!(data)
        new(data).serialize!
      rescue StandardError => e
        puts "e"
        nil
      end

      def initialize(params = {})
        @item     = Item.find(params[:item_id])
        @quantity = params[:quantity].to_i
      end

      def serialize!
        {
          item:,
          price:,
          quantity:
        }
      end

      def price
        item.price * quantity
      end
    end
  end
end
