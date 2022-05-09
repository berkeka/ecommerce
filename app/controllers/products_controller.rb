# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_category, only: %i[by_category by_subcategory]
  before_action :set_subcategory, only: :by_subcategory
  before_action :set_brand, only: :by_brand
  before_action :set_product, only: %i[show]

  before_action :authenticate_user!, :authorize_admin, only: %i[new create update delete]

  def index
    @products = Product.all
    @title = 'Products'
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

  def show
    @discount = @product.multi_discounts.sample
    if @discount
      discount_product_ids = @discount.multi_discount_products.pluck(:product_id)
      @discount_products = Product.where(id: discount_product_ids)
    end
    @meta_tags = join_meta_tags(@product.tags)
  end

  def new
    @brands = Brand.all
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    @product.category = @product.sub_category.category
    @product.main_image.attach(params[:product][:main_image]) if params[:product][:main_image]
    @product.images.attach(params[:product][:images]) if params[:product][:images]

    tags = tag_names.each.inject([]) do |tags, tag|
      tags << Tag.find_or_initialize_by(content: tag)
    end

    p tags

    @product.tags = tags

    if @product.save
      redirect_to @product, status: :created
    else
      flash[:alert] = @product.errors
      redirect_to new_product_path
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :sub_category_id,
                                    :brand_id, :main_image, :images)
  end

  def tag_names
    # Because of some issue I've encountered with tagify package we need to do this ugliness 
    raw_tag_input = params[:product][:tag_list]
    tag_params = JSON.parse(raw_tag_input)

    tag_params.each.inject([]) { |arr, param| arr.push(param['value']) }
  end

  def set_product
    @product = Product.includes(:multi_discounts, :tags).find(params[:id])
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

  def join_meta_tags tags
    p tags.each.inject("") {|str,tag| str + "#{tag.content}, "}
  end
end
