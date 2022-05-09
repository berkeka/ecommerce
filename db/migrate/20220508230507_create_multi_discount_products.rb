class CreateMultiDiscountProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :multi_discount_products do |t|
      t.references :product, null: false, foreign_key: true
      t.references :multi_discount, null: false, foreign_key: true

      t.timestamps
    end
  end
end
