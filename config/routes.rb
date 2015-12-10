require 'sidekiq/web'
ShopAnnarborteesCom::Application.routes.draw do

  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Spree relies on it being the default of "spree"
  mount Spree::Core::Engine, :at => '/'
  authenticate :spree_user, lambda{ |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'

  end

  get '/checkedout' => 'spree/checkout#complete', as: :checkedout

  get '/support/show', to: redirect('/help')




end

Spree::Core::Engine.routes.append do
  namespace :admin do
    resources :reports, :only => [:index] do
      collection do
        get :sales_tax
        post :sales_tax
      end
    end
  end
end