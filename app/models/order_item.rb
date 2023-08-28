# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  validates :quantity, numericality: { greater_than: 0 }
end
