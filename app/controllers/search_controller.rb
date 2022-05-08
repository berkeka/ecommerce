class SearchController < ApplicationController
  def results
    @products = Product.where("name ILIKE '%#{sanitized_query}%'")
  end

  private

  def sanitized_query
    ActiveRecord::Base.sanitize_sql(params[:query])
  end
end
