Rails.application.routes.draw do
  devise_for :users
  
  resources :accounts, only: [] do
    collection do
    	get :balance
    	get :history
      get :transfer_page
    	post :withdraw
    	post :deposit
      post :transfer
    end
  end

  root to: "accounts#balance"
end
