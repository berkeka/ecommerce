class CreateBrandOffers < ActiveRecord::Migration[7.0]
  def change
    create_table :brand_offers do |t|
      t.references :brand, null: false, foreign_key: true
      t.references :offer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
