# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_category, only: %i[by_category by_subcategory]
  before_action :set_subcategory, only: :by_subcategory
  before_action :set_brand, only: :by_brand
  before_action :set_product, only: %i[show]

  def index
    @products = Product.all
  end

  def by_category
    @products = Product.where(category: @category)
    @title = @category.name

    render :index
  end

  def by_subcategory
    @products = Product.where(sub_category: @subcategory)
    @title = "#{@category.name} | #{@subcategory.name}"

    render :index
  end

  def by_brand
    @products = Product.where(brand: @brand)
    @title = @brand.name

    render :index
  end

  def show; end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_subcategory
    @subcategory = SubCategory.find(params[:sub_category_id])
  end

  def set_brand
    @brand = Brand.find(params[:brand_id])
  end
end