# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :category
  belongs_to :sub_category
  belongs_to :brand
end
