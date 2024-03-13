Rails.application.routes.draw do
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: 'public' do
    get 'users/mypage' => 'users#show'
    patch 'users/mypage' => 'users#update'
    get 'users/mypage/edit' => 'users#edit'
    get 'users/confirm' => 'users#confirm'
    patch 'users/withdrawal' => 'users#withdrawal'
  end
end
