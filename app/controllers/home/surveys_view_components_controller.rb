module Home
  class SurveysViewComponentsController < ApplicationController
    def index
      @new_survey = Survey.new
      @surveys = SurveyDecorator.decorate_collection(SurveysQuery.call(params))
    end
  end
end
