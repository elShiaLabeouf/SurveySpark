class SurveyTrComponent < ViewComponent::Base
  with_collection_parameter :survey
  attr_reader :survey

  def initialize(survey:)
    @survey = survey
  end
end
