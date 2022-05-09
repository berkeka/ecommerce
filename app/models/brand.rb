# frozen_string_literal: true

class Brand < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :brand_offers, dependent: :destroy
  has_many :offers, through: :brand_offers
end
