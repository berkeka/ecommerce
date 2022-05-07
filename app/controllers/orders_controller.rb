# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin, only: :index
  before_action :set_products, :set_amounts, only: :create

  def my_orders
    @orders = current_user.orders
  end

  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.new

    @product_ids.zip(@amounts).each do |id, amount|
      @order.order_products.new(product_id: id, amount: amount)
    end

    if @order.save
      render :new, status: :created
    else
      flash[:alert] = @order.errors
      render :new
    end
  end

  def set_products
    @product_ids = params[:order][:products].first.split(',').map(&:to_i)
  end

  def set_amounts
    @amounts = params[:order][:amounts].first.split(',').map(&:to_i)
  end
end
