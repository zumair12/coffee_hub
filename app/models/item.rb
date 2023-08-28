# frozen_string_literal: true

class Item < ApplicationRecord
  has_many :discounts, dependent: :destroy
  has_many :deal_discounts, class_name: "Discount", foreign_key: :applicable_item_id, dependent: :destroy
  has_many :order_items
  has_many :orders, through: :order_items

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :tax_rate, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  def all_discounts
    discounts.self_discounts + deal_discounts
  end
end
