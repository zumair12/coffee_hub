class CreateOrderItem < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :price, precision: 14, scale: 2
      t.decimal :discount, precision: 14, scale: 2
      t.decimal :taxable_amount, precision: 14, scale: 2
      t.decimal :payable, precision: 14, scale: 2

      t.timestamps
    end
  end
end
