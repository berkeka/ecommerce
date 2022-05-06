# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  before_action :fetch_categories

  protected

  def authorize_user
    redirect_to root_path if current_user.nil? || !current_user.is_admin?
  end

  def fetch_categories
    @categories = Category.includes(:sub_categories).all
  end

  def record_not_found
    render :index
  end
end
