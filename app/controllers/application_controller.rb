# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :fetch_categories

  protected

  def fetch_categories
    @categories = Category.includes(:sub_categories).all
  end
end
