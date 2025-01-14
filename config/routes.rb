Rails.application.routes.draw do
  root "home/surveys#index"

  resources :surveys, only: %i[new create] do
    resources :responses, only: %i[create], controller: "survey_responses"
  end

  get "/stream", to: "home/surveys_stream#index"
  get "/view_components", to: "home/surveys_view_components#index"
end
