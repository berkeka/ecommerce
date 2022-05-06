# frozen_string_literal: true

class BrandsController < ApplicationController
  before_action :set_brand, only: %i[show]

  def show; end

  private

  def set_brand
    @brand = Brand.find(params[:id])
  end
end
