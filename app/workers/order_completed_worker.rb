class OrderCompletedWorker
  include Sidekiq::Worker

  def perform(order_id)
    order = Order.find(order_id)
    # Perform your desired Action Cable method call here
    order.completed!
  end
end
