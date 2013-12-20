SampleApp::Application.routes.draw do
  #
  # resources
  resources :users do
    member do
      get :following, :followers
    end
  end
  
  resources :sessions,      only: [:new, :create, :destroy]
  resources :microposts,    only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

  # root path.  This is just the domain name
  root  'static_pages#home'
  # equal to match '/', to: 'static_pages#home', via: 'get'

  # static pages paths.  These are to make the paths a little more succinct 
  # because these are commonly used pages.  We could just as easily visit
  # /static_pages/home this just makes it easier. 
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'

  #users paths
  match '/signup',  to: 'users#new',             via: 'get'

  #sessions paths
  match '/signin',   to: 'sessions#new',         via: 'get'
  match '/signout',  to: 'sessions#destroy',     via: 'delete'



  #
  #
  # =>      ========= NOTES ON ROUTES AND ROUTING =========
  #
  #  TIP: to get all routes use:
  # => $ rake routes
  #
  # Routes matches CONTROLLER ACTIONS to PATHS ON YOUR SITE.
  # Controller actions are notated in routes as 'controller_name#action_name'

      # Example above:  'match '/about/, to: 'static_pages#about', via: 'get'

  # '/about/' is a path on the website
  # 'static_pages#about' maps to the about action in the static_pages controller

  #  This also sets up a named route for the path!  about_path which is equal to '/about/'
   

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
