# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_category, only: %i[by_category by_subcategory]
  before_action :set_subcategory, only: :by_subcategory
  before_action :set_brand, only: :by_brand
  before_action :set_product, only: %i[show]

  before_action :authenticate_user!, :authorize_admin, only: %i[new create update delete]

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

  def new
    @brands = Brand.all
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.category = @product.sub_category.category
    @product.images.attach(params[:product][:main_image]) if params[:product][:main_image]

    if @product.save
      render :show, status: :created
    else
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :sub_category_id, :brand_id, :main_image, :images)
  end

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
