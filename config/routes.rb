Rails.application.routes.draw do
  root "home#index"
  
  devise_for :users

  resources :products

  resources :brands, except: %i[index] do
    get 'products', to: "products#by_brand"
  end
  
  resources :categories do
    get 'products', to: "products#by_category"
    
    resources :sub_categories do
      get 'products', to: "products#by_subcategory"
    end
  end
end
