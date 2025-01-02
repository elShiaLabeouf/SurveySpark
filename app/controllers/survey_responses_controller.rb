# frozen_string_literal: true

class SurveyResponsesController < ApplicationController
  def create
    service = SurveyResponses::Create.new(survey_id: params[:survey_id])
    service.call(survey_response_params: survey_response_params.merge(user_id: current_user.id))
    @survey_decorated = SurveyDecorator.decorate(service.survey)
    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def survey_response_params
    params.require(:survey_response).permit(:answer)
  end
end
