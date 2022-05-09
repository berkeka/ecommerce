class BulkController < ApplicationController
  before_action :authenticate_user!, :authorize_admin

  def create
    io_file = params[:json_file]
    file_data = File.read(io_file)
    data = JSON.parse(file_data)
    error = nil
    
    data['categories'].each do |category|
      Category.create(category_params)
    end

    data['subcategories'].each do |subcategory|
      category = Category.find_or_create_by(name: subcategory['name'])
      SubCategory.create(subcategory_params(subcategory))
    end

    data['brands'].each do |brand|
      Brand.create(brand_params(brand))
    end

    # data['products'].each do |product|
    #   category = Category.find_or_create_by(name: product['category'])
    #   subcategory = SubCategory.find_or_create_by(name: product['subcategory'])
    #   brand = Brand.find_or_create_by(name: product['brand'])

    #   p product['tags']

    #   tags = product['tags'].each.inject([]) do |tags, tag|
    #     tags << Tag.find_or_initialize_by(content: tag)
    #   end

    #   p = Product.new(product_params(product))
    #   p.sub_category = subcategory
    #   p.category = category
    #   p.brand = brand
    #   p.tags = tags

    #   unless p.save
    #     error = p.errors
    #   end
    # end
    
    flash[:alert] = error if error
    redirect_to new_bulk_path
  end

  def category_params(category)
    {name: category['name']}
  end

  def subcategory_params(subcategory)
    {name: subcategory['name']}
  end

  def brand_params(brand)
    {name: brand['name']}
  end

  def product_params(product)
    {
      name: product['name'],
      description: product['description'],
      price: product['price']
    }
  end
end
