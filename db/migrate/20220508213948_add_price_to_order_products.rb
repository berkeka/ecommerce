class AddPriceToOrderProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :order_products, :price, :decimal
  end
end
