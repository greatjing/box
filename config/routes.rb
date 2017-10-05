Rails.application.routes.draw do

  devise_for :users

  resources :events

  namespace :admin do
    root "events#index"
    resources :events do
      resources :tickets, :controller => "event_tickets"
      # 批量删除
      collection do
        post :bulk_update
      end
      # 用户自定义显示的顺序
      member do
        post :reorder
      end
    end

    resources :users do
      resource :profile, :controller => "user_profiles"
    end
  end

  root "events#index"

  get "/faq" => "pages#faq"

  resource :user

end
