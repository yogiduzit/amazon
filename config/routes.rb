Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Index page
  get('/', {to: 'welcome#index', as: 'root'});

  # About page
  get('/about', {to: 'welcome#about'});

  # Contacts Page
  get('/contact', {to: 'contacts#index'});

  # New product page
  get '/products/new', {to: 'products#new'}

  # All products page
  get '/products', {to: 'products#index'}

  # Get a product with a particular id
  get '/products/:id', {to: 'products#show', as: 'product'}

  # Get the product information in form
  get 'products/:id/edit', {to: 'products#edit', as:'edit_product'}

  # Create new contact
  post('/contact', {to: 'contacts#create'});
  
  # Create new product
  post '/products', {to: 'products#create'}

  # Update product
  patch '/products/:id', {to: 'products#update'}

  # Delete a product
  delete '/products/:id', {to: 'products#delete'}
end
