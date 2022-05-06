# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  before_action :fetch_categories

  protected

  def fetch_categories
    @categories = Category.includes(:sub_categories).all
  end

  def record_not_found
    render :index
  end
end
