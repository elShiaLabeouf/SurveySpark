class SurveyResultsComponent < ViewComponent::Base
  attr_reader :survey

  def initialize(survey:)
    @survey = survey
  end
end
