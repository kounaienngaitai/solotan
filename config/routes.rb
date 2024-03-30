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
    resources :posts, except: [:new]
    resources :users, only: [:index, :show, :edit, :update]

    get 'users/posts/:id' => 'users#posts', as: 'user_posts'
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


end