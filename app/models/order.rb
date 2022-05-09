# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products

  before_save :calculate_total

  def calculate_total
    self.total ||= self.order_products.each.inject(0.0) {|sum, p| sum += p.subtotal}
  end
end
