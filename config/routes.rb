Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    namespace :v1 do
    	post 'create_and_fill_seats', to: 'seats#create_and_fill_seats', as: 'create_and_fill_seats'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
