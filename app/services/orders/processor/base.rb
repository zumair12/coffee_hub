# frozen_string_literal: true

module Orders
  module Processor
    module Base
      include Utils::OrderItemCalculation

      def self.included(base)
        base.extend ClassMethods
        base.attr_accessor :order, :order_items
      end

      def initialize(params = {})
        @order = params[:order]
        @order_items = params[:order_items]
      end

      module ClassMethods
        def call!(data)
          new(data).execute!
        end
      end
    end
  end
end
