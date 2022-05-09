class Offer < ApplicationRecord
  has_one :brand_offer
  has_one :brand, through: :brand_offer
  has_one_attached :image
end
