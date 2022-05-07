# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :category
  belongs_to :sub_category
  belongs_to :brand
  has_many :order_products

  has_one_attached :main_image, dependent: :destroy
  has_many_attached :images, dependent: :destroy

  validates :price, numericality: { greater_than_or_equal_to: 1.0, less_than_or_equal_to: 9_999_999.0 }
end
