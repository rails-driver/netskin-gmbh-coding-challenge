Rails.application.routes.draw do
  resources :users

  resources :barcodes do
    collection do
      match :import, via: %i(get post)
      post :generate
    end
  end

  root to: "pages#root"
end
