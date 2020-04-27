Rails.application.routes.draw do
  get 'welcome/index'
  root to: 'welcome#index'


  resources :payers, only: [:create, :show, :index] do
    member do
      post :generate_bill
    end
  end

  resources :bills, only: [:fetch] do
    collection do
      post :fetch
    end
  end
end
