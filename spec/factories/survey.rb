# frozen_string_literal: true

FactoryBot.define do
  factory :survey do
    content { Faker::Quote.yoda }

    transient do
      yes_count { nil }
      no_count { nil }
    end

    before(:create) do |survey, evaluator|
      next unless evaluator.yes_count && evaluator.no_count

      survey.response_statistics = {
        SurveyResponse.answers[:yes] => evaluator.yes_count,
        SurveyResponse.answers[:no] => evaluator.no_count
      }
    end

    trait :with_responses do
      after(:create) do |survey, evaluator|
        raise "yes_count and no_count must be provided" unless evaluator.yes_count && evaluator.no_count

        create_list(:survey_response, evaluator.yes_count, survey: survey, answer: "yes", user: create(:user))
        create_list(:survey_response, evaluator.no_count, survey: survey, answer: "no", user: create(:user))
      end
    end
  end
end
