# frozen_string_literal: true

module ProductsHelper
  module_function

  def select_category_list categories
    categories.each.inject({}) do |hash, category|
      hash[category.name] = category.sub_categories.each.inject([]) do |arr, subcategory|
        arr << [subcategory.name, subcategory.id]
      end
      hash
    end
  end
end
