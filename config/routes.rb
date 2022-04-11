# frozen_string_literal: true

Rails.application.routes.draw do
  get 'recipes/index'
  get 'recipes/search'
  get 'recipes/export'
  root to: 'recipes#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
