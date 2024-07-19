# frozen_string_literal: true

class SurveyResponse < ApplicationRecord
  belongs_to :survey
  belongs_to :user

  enum answer: { yes: 0, no: 1 }
end
