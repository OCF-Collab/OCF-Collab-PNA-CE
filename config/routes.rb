Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :competencies do
    get :asset_file
  end

  namespace :competency_frameworks do
    get :asset_file
  end
end
