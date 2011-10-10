SAP::Application.routes.draw do
  
  resources :events
  resources :appointments
  
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'events#index'

  # for jasmine testing 'localhost:3000/jasmine'
  #if ["development", "test"].include? Rails.env
   # mount Jasminerice::Engine => "/jasmine"
  #end
 
end
