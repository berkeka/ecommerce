class MultiDiscountsController < ApplicationController
  before_action :set_multi_discount, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, :authorize_admin

  def index
    @multi_discounts = MultiDiscount.all
  end

  def show
  end

  def new
    @products = Product.all
    @multi_discount = MultiDiscount.new
  end

  def edit
  end

  def create
    @multi_discount = MultiDiscount.new(multi_discount_params)

    respond_to do |format|
      if @multi_discount.save
        format.html { redirect_to multi_discount_url(@multi_discount), notice: "Multi discount was successfully created." }
        format.json { render :show, status: :created, location: @multi_discount }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @multi_discount.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @multi_discount.update(multi_discount_params)
        format.html { redirect_to multi_discount_url(@multi_discount), notice: "Multi discount was successfully updated." }
        format.json { render :show, status: :ok, location: @multi_discount }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @multi_discount.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @multi_discount.destroy

    respond_to do |format|
      format.html { redirect_to multi_discounts_url, notice: "Multi discount was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_multi_discount
      @multi_discount = MultiDiscount.includes(:products).find(params[:id])
    end

    def multi_discount_params
      params.require(:multi_discount).permit(:discount_amount, :product_ids)
    end
end
