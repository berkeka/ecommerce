# frozen_string_literal: true

class SubCategory < ApplicationRecord
  belongs_to :category
  has_many :products, dependent: :destroy
end
