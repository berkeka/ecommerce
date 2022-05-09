class MultiDiscount < ApplicationRecord
  has_many :multi_discount_products
  has_many :products, through: :multi_discount_products
end
