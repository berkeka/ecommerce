class OffersController < ApplicationController
  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.image.attach(params[:offer][:image])
    @offer.brand = Brand.find(params[:offer][:brand_id])

    if @offer.save
      redirect_to root_path
    else
      render :new
    end
  end

  def offer_params
    params.require(:offer).permit(:name, :image)
  end
end
