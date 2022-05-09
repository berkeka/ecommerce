class MultiDiscountProduct < ApplicationRecord
  belongs_to :product
  belongs_to :multi_discount
end
