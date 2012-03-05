ActionController::Routing::Routes.draw do |map|
  # map.namespace :admin, :member => { :remove => :get } do |admin|
  #   admin.resources :minutes
  # end

  map.namespace :admin, :collection => { :upload => :post } do |admin|
    admin.resources :minutes
  end
end
