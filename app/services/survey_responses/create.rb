# frozen_string_literal: true

module SurveyResponses
  class Create
    attr_reader :survey

    def initialize(survey_id:)
      @survey = Survey.find(survey_id)
    end

    def call(survey_response_params:)
      survey_response = survey.survey_responses.create!(survey_response_params)
      survey.update_statistics(survey_response.answer)
    end
  end
end
