# frozen_string_literal: true

module ProductsHelper
  module_function

  def select_category_list(categories)
    categories.each.each_with_object({}) do |category, hash|
      hash[category.name] = category.sub_categories.each.reduce([]) do |arr, subcategory|
        arr << [subcategory.name, subcategory.id]
      end
    end
  end
end
