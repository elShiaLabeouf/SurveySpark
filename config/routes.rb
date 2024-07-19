Rails.application.routes.draw do
  root "surveys#index"

  resources :surveys, only: %i[new create] do
    resources :responses, only: %i[create], controller: "survey_responses"
  end
end
