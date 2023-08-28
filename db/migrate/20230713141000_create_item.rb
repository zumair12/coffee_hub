class CreateItem < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :price, precision: 14, scale: 2
      t.decimal :tax_rate, precision: 14, scale: 2

      t.timestamps
    end
  end
end
