Rails.application.routes.draw do
  resources :movies do
    collection do
      post 'sort_title'
    end
  end
  
  root to: redirect('/movies')
end
