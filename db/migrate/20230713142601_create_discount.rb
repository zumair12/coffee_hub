class CreateDiscount < ActiveRecord::Migration[7.0]
  def change
    create_table :discounts do |t|
      t.references :item, null: false, foreign_key: true
      t.references :applicable_item, foreign_key: { to_table: :items }
      t.decimal :discount_rate, precision: 4, scale: 2
      t.decimal :cap_amount, precision: 14, scale: 2

      t.timestamps
    end
  end
end
