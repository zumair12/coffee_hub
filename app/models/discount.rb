# frozen_string_literal: true

class Discount < ApplicationRecord
  belongs_to :item
  belongs_to :applicable_item, class_name: "Item", foreign_key: :applicable_item_id, optional: true

  validates :item_id, presence: true
  validates :discount_rate, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :self_discounts, -> {
    where(applicable_item: nil)
  }

  scope :deal_discounts, -> {
    where.not(applicable_item: nil)
  }

  def apply_on_associated_item?
    applicable_item.present?
  end

  def calculate_discount(price)
    discount_amount = (price * discount_rate) / 100

    allowed_discount_amount(discount_amount)
  end

  def allowed_discount_amount(discount_amount)
    return discount_amount if cap_amount.nil? # no cap limit apply

    [discount_amount, cap_amount].min
  end
end
