# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :order_products, dependent: :destroy

  before_save :calculate_total

  private

  def calculate_total
    self.total ||= 0 # self.product_orders
  end
end
