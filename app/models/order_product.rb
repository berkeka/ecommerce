# frozen_string_literal: true

class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  def subtotal
    @subtotal ||= self.amount * self.price
  end
end
