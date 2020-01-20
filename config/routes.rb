# frozen_string_literal: true

Rails.application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  end

  devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  scope '(:locale)', locale: /#{I18n.available_locales.map(&:to_s).join('|')}/ do
    devise_scope :user do
      root to: 'devise/sessions#new'
    end

    devise_for :users, skip: :omniauth_callbacks, controllers: {
      registrations: 'users/registrations',
    }

    resources :books

    resources :profiles, only: %i[index show edit update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
