# frozen_string_literal: true

class Survey < ApplicationRecord
  has_many :survey_responses, dependent: :destroy

  validates :content, presence: true

  serialize :response_statistics, coder: JSON

  def update_statistics(answer_type)
    json_key = SurveyResponse.answers[answer_type].to_s
    response_statistics[json_key] ||= 0
    response_statistics[json_key] += 1

    save!
  end
end
