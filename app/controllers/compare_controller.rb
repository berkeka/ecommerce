class CompareController < ApplicationController
  before_action :set_first_product
  before_action :set_second_product, only: :show

  def index; end

  def show; end

  private

  def set_first_product
    @first_product = Product.find(params[:product_id])
  end

  def set_second_product
    @first_product = Product.find(params[:id])
  end
end
