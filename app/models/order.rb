# frozen_string_literal: true

class Order < ApplicationRecord
  include AASM

  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items

  validates :customer_name, :customer_contact, :order_type, presence: true
  validate :at_least_one_order_item

  accepts_nested_attributes_for :order_items

  enum order_type: {
    dine_in: 'Dine In',
    take_away: 'Take Away'
  }


  aasm column: :state do
    state :pending, initial: true
    state :processing
    state :complete

    event :process do
      transitions from: :pending, to: :processing
      after do
        notify_order
      end
    end

    event :completed do
      transitions from: :processing, to: :complete
      after do
        notify_order
      end
    end
  end

  def at_least_one_order_item
    return true if order_items.any?

    errors.add :order_items, "Atleast one item should exists"

    false
  end

  def scheduled_jobs
    OrderProcessWorker.perform_in(10.seconds, id)
    OrderCompletedWorker.perform_in(20.seconds, id)
  end

  def notify_order
    ActionCable.server.broadcast('order_creation_channel', { id: id, state: state.titleize,  message: "Order No# #{id} is #{state}" })
  end
end
