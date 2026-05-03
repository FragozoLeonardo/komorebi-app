# frozen_string_literal: true

Rails.application.routes.draw do
  get "study/n5", to: "study#n5", as: :study_n5

  resources :kanjis, only: [ :show ]
end
