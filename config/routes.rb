Rails.application.routes.draw do
  devise_for :users
  
  resources :accounts, only: [] do
    collection do
    	get :balance
    	get :history
    end
  end

  root to: "accounts#balance"
end
