Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#home'
  get 'home/about' => 'homes#about'
  resources :users, only: [:index, :show, :edit, :update]
  resources :books, only: [:index, :show, :create, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy] #単数（ネスト）にすると（そのContorollerの）idがリクエストに含まれない。つまり、BookのIdのみ拾ってくる。
  end
  #resources :book_comments, only: [:destroy] #単数にすると（そのContorollerの）idがリクエストに含まれない。つまり、BookのIdのみ拾ってくる。
end
