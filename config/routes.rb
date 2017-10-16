Rails.application.routes.draw do

  devise_for :users

  resources :events do
    resources :registrations do
      # 针对单个registration进行操作，为什么两种registration路由，是需要不同跳转吗？——这属于用户的操作
      member do
        get "steps/1" => "registrations#step1", :as => :step1
        patch "steps/1/update" => "registrations#step1_update", :as => :update_step1
        get "steps/2" => "registrations#step2", :as => :step2
        patch "steps/2/update" => "registrations#step2_update", :as => :update_step2
        get "steps/3" => "registrations#step3", :as => :step3
        patch "steps/3/update" => "registrations#step3_update", :as => :update_step3
      end
    end
  end

  namespace :admin do
    root "events#index"
    # 版本控制
    resources :versions do
      post :undo
    end

    resources :events do
      # 票务
      resources :tickets, :controller => "event_tickets"
      # 报名信息——下面属于管理员的操作
      resources :registrations, :controller => "event_registrations" do
        # csv导入数据
        collection do
          post :import
        end
      end

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
