# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @offers = Offer.includes(:brand).all
  end
end
