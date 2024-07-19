# frozen_string_literal: true

class SurveyResponsesController < ApplicationController
  SURVEY_CREATE_RETRIES = 15

  def create
    service = SurveyResponses::Create.new(survey_id: params[:survey_id])
    service.call(survey_response_params: survey_response_params.merge(user_id: current_user.id))
    @survey_decorated = SurveyDecorator.decorate(service.survey)
    respond_to do |format|
      format.turbo_stream
    end
  rescue ActiveRecord::StaleObjectError => e
    sleep(0.1)
    @retry ||= 0
    retry if (@retry += 1) <= SURVEY_CREATE_RETRIES
    raise e
  end

  private

  def survey_response_params
    params.require(:survey_response).permit(:answer)
  end
end
