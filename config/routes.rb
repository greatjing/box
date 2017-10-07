Rails.application.routes.draw do

  devise_for :users

  resources :events do
    resources :registrations do
      get "steps/2" => "registrations#step2", :as => :step2
      patch "steps/2/update" => "registrations#step2_update", :as => :update_step2
      get "steps/3" => "registrations#step3", :as => :step3
      patch "steps/3/update" => "registrations#step3_update", :as => :update_step3
    end
  end

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
