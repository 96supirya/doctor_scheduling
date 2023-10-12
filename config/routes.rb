Rails.application.routes.draw do
  resources :doctors, only: %w[index create show] do
    member do
    get 'working_hours'
    get 'availability'
    post 'book_slot'
    end
  end

  resources :appointments, only: [:update, :destroy]
end

