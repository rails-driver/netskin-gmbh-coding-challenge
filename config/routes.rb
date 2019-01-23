Rails.application.routes.draw do
  resources :users

  resources :barcodes do
    collection do
      match :import, via: %i(get post)
    end
  end

  root to: "pages#root"
end
