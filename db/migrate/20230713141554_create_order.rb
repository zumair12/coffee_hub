class CreateOrder < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :customer_name
      t.string :customer_contact
      t.string :order_type
      t.string :state
      t.decimal :price, precision: 14, scale: 2
      t.decimal :discount, precision: 14, scale: 2
      t.decimal :taxable_amount, precision: 14, scale: 2
      t.decimal :payable, precision: 14, scale: 2

      t.timestamps
    end
  end
end
