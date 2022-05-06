# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :category
  belongs_to :sub_category
  belongs_to :brand

  has_one_attached :main_image, dependent: :destroy
  has_many_attached :images, dependent: :destroy
end
