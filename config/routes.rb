Rails.application.routes.draw do
  namespace :public do
    get 'posts/new'
    get 'posts/show'
    get 'posts/index'
    get 'posts/edit'
  end
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admins, skip: [:registrations, :passwords], controllers: {
  sessions: 'admin/sessions'
  }

  namespace :admin do
    root 'homes#top', as: 'top'
  end

  scope module: 'public' do
    root 'homes#top', as: 'top'

    get 'users/mypage' => 'users#show'
    get 'users/mypage/edit' => 'users#edit'
    patch 'users/mypage', to: 'users#update', as: 'users_mypage_update'
    get 'users/confirm' => 'users#confirm'
    patch 'users/withdrawal' => 'users#withdrawal'

    resources :posts
  end

  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end


end