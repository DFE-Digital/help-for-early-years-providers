Rails.application.routes.draw do
  get 'health' => 'rails/health#show', as: :rails_health_check

  scope via: :all do
    get '/404', to: 'errors#not_found'
    get '/422', to: 'errors#unprocessable_entity'
    get '/429', to: 'errors#too_many_requests'
    get '/500', to: 'errors#internal_server_error'
  end

  resources :feedbacks, only: %i[create]
  resources :settings, only: %i[show create]

  %w[accessibility-statement contact-us disclaimer].each do |static_page|
    get "/#{static_page}", to: "pages##{static_page.underscore}"
  end

  # explicit redirect for old link
  get '/get-help-to-improve-your-practice/send-meeting-the-needs-of-all-children', to: redirect('/get-help-to-improve-your-practice/meeting-the-needs-of-all-children')

  get '/:section/:slug', to: 'pages#show'
  get ':slug', to: 'pages#show'

  root to: 'pages#index'
end
