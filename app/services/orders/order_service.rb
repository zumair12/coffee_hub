# frozen_string_literal: true

module Orders
  class OrderService
    attr_accessor :params, :order, :serialized_order

    def self.placeOrder(params)
      new(params).execute!
    rescue StandardError => e
      raise "Raise error for now #{e}"
    end

    def initialize(params = {})
      @params = params
    end

    def execute!
      serialized!

      apply_discount!

      deduct_tax!

      calculate_payable!

      build!

      order
    end

    def serialized!
      @serialized_order = Serializers::OrderSerializer.call!(params)
    end

    def apply_discount!
      @serialized_order = Processor::Discount.call!(serialized_order)
    end

    def deduct_tax!
      @serialized_order = Processor::Tax.call!(serialized_order)
    end

    def calculate_payable!
      @serialized_order = Processor::Payable.call!(serialized_order)
    end

    def build!
      @order = ::Order.new(serialized_order[:order])

      serialized_order[:order_items].each do |line_item|
        item = line_item.delete(:item)
        order_item = OrderItem.new(line_item)
        order_item.item = item

        @order.order_items << order_item
      end

      @order.save
    end
  end
end
