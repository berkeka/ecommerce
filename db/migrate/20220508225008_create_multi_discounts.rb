class CreateMultiDiscounts < ActiveRecord::Migration[7.0]
  def change
    create_table :multi_discounts do |t|
      t.integer :discount_amount

      t.timestamps
    end
  end
end
