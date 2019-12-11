Rails.application.routes.draw do

  devise_for :users
  root                          to: 'items#index'
  get  'signup',                to: 'sign_ups#signup_select'
  get  'signup/registration',   to: 'sign_ups#user_baseinfo'
  post 'signup/registration',   to: 'sign_ups#user_baseinfo_validate'
  get  'signup/tel',            to: 'sign_ups#user_tel'
  post 'signup/tel',            to: 'sign_ups#user_tel_validate'
  get  'signup/tel/auth',       to: 'sign_ups#user_tel_auth'
  post 'signup/tel/auth',       to: 'sign_ups#user_create'
  get  'registrate/address',    to: 'sign_ups#user_address'
  post 'registrate/address',    to: 'sign_ups#user_address_create'
  get  'registrate/card',       to: 'sign_ups#user_card'
  post 'registrate/card',       to: 'sign_ups#user_card_create'
  get  'registrate/complete',   to: 'sign_ups#user_complete'
  get  'mypage/identification', to: 'users#idetification'
  get  'mypage/logouts',        to: 'users#logouts'
  get  'items/mid_category',    to: 'items#mid_category'
  get  'items/small_category',  to: 'items#small_category'
  resources :items do
    collection do
      get 'search',             to: 'items#search'
      get 'category',           to: 'items#category_index'
      get 'category/search',    to: 'items#category_search'
    end
    resources :images
    resources :purchases do
      collection do
        get  'done',   to: 'purchases#done'
      end
    end
  end
  resources :users do
    member do
      resources :cards
      resources :address
      get  'identification', to: 'users#idetification'
      get  'logouts',        to: 'users#logouts'
      get  'mypage/SNS',        to: 'users#SNS'
    end
  end
end
