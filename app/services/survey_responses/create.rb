# frozen_string_literal: true

module SurveyResponses
  class Create
    SURVEY_CREATE_RETRIES = 15

    attr_reader :survey

    def initialize(survey_id:)
      @survey = Survey.find(survey_id)
    end

    def call(survey_response_params:)
      survey_response = survey.survey_responses.create!(survey_response_params)
      survey.update_statistics(survey_response.answer)
    rescue ActiveRecord::StaleObjectError => e
      sleep(0.1)
      @retry ||= 0
      retry if (@retry += 1) <= SURVEY_CREATE_RETRIES
      raise e
    end
  end
end
