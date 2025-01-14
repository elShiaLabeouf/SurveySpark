module Home
  class SurveysController < ApplicationController
    def index
      @new_survey = Survey.new
      @surveys = SurveyDecorator.decorate_collection(SurveysQuery.call(params))
    end

    def new
      @survey = Survey.new
    end

    def create
      new_survey = Survey.new(survey_params)

      if new_survey.save
        @survey_decorated = SurveyDecorator.decorate(new_survey)
        respond_to do |format|
          format.turbo_stream
        end
      else
        respond_to do |format|
          format.turbo_stream do
            render("surveys/create_error",
                   locals: { new_survey: new_survey, expanded: false },
                   status: :unprocessable_entity)
          end
        end
      end
    end

    private

    def survey_params
      params.require(:survey).permit(:content)
    end
  end
end
