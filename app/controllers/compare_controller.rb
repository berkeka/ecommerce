# frozen_string_literal: true

class CompareController < ApplicationController
  before_action :set_first_product
  before_action :set_second_product, only: :show

  def index
    @products = Product.where(sub_category: @first_product.sub_category)
  end

  def show; end

  private

  def set_first_product
    @first_product = Product.includes(:category, :sub_category).find(params[:product_id])
  end

  def set_second_product
    @second_product = Product.find(params[:id])
  end
end
