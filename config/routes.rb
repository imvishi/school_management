Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "admin/users#login_page"
  namespace :admin do
    resources :courses, except: [:show]
    resources :schools, except: [:show] do
      resources :batches
    end
    resources :users, only: [] do
      member do
        post :request_batch
        get :batches
      end
      collection do
        get :batch_page
        post :select_user
        get :login_page
        get :welcome_page
      end
    end
  end
end
