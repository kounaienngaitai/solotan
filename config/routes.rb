Rails.application.routes.draw do
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: 'admin/sessions'
  }

  namespace :admin do
    root 'homes#top', as: 'top'

    resources :posts, except: [:new] do
      resources :post_comments, only: [:destroy]
    end

    resources :users, only: [:index, :show, :edit, :update] do
      get 'posts/:id' => 'users#posts', as: 'user_posts', on: :collection
    end

    get 'confirm/posts' => 'posts#confirm', as: 'posts_confirm'
  end

  scope module: 'public' do
    root 'homes#top', as: 'top'

    get 'users/mypage' => 'users#show'
    get 'users/mypage/edit' => 'users#edit'
    patch 'users/mypage', to: 'users#update', as: 'users_mypage_update'
    get 'users/confirm' => 'users#confirm'
    patch 'users/withdrawal' => 'users#withdrawal'


    get 'confirm/posts' => 'posts#confirm', as: 'posts_confirm'
    resources :posts
  end

  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  namespace :public do
    resources :posts do
      resources :post_comments, only: [:create, :destroy]
    end
  end

end