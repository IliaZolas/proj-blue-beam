Rails.application.routes.draw do
  # get 'pages/home'
  get '/' => 'pages#home'

  get "/:lat/:lon", to: "pages#home" ,  :constraints => { :lat => /[0-z\.]+/, :lon => /[0-z\.]+/ }
  
end
