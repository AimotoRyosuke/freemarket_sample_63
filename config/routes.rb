Rails.application.routes.draw do

  devise_for :users

  root                          to: 'items#index'
  get  'signin',                to: 'sign_in#signin'
  get  'signup',                to: 'sign_ups#signup_select'
  get  'signup/registration',   to: 'sign_ups#user_baseinfo'
  post 'signup/registration',   to: 'sign_ups#user_baseinfo_validate'
  get  'signup/tel',            to: 'sign_ups#user_tel'
  post 'signup/tel',            to: 'sign_ups#user_tel_validate'
  get  'signup/tel/auth',       to: 'sign_ups#user_tel_auth'
  post 'signup/tel/auth',       to: 'sign_ups#user_create'
  get  'registrate/address',    to: 'sign_ups#user_address'
  post 'registrate/address',    to: 'sign_ups#user_address_create'
  get  'registrate/credit',     to: 'sign_ups#user_credit'
  post 'registrate/credit',     to: 'sign_ups#user_credit_create'
  get  'registrate/complete',   to: 'sign_ups#user_complete'
  get  'mypage/identification', to: 'users#idetification'
  get  'mypage/address',        to: 'users#address'
  get  'mypage/logouts',        to: 'users#logouts'
  resources :items do
    collection do
      get 'search',            to: 'items#search'
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
    resources :credits
    resources :cards
    resources :address
    member do
      get  'identification', to: 'users#idetification'
      get  'logouts',        to: 'users#logouts'
    end
  end
end
