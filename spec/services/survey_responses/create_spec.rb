# frozen_string_literal: true

require "rails_helper"

RSpec.describe SurveyResponses::Create do
  let!(:yes_count) { 11 }
  let!(:no_count) { 4 }
  let!(:user) { create(:user) }
  let!(:survey) { create(:survey, yes_count: yes_count, no_count: no_count) }

  describe "#call" do
    context "with valid params" do
      let!(:yes_survey_response_params) { { answer: "yes", user_id: user.id } }
      let!(:no_survey_response_params) { { answer: "no", user_id: user.id } }

      it "successfully creates a SurveyResponse record and updates survey's counters" do
        service = described_class.new(survey_id: survey.id)

        expect do
          service.call(survey_response_params: yes_survey_response_params)
        end.to change { SurveyResponse.where(answer: "yes", user_id: user.id).count }.by(1)

        expect(survey.reload.response_statistics[SurveyResponse.answers[:yes].to_s]).to eq(yes_count + 1)

        expect do
          service.call(survey_response_params: no_survey_response_params)
        end.to change { SurveyResponse.where(answer: "no", user_id: user.id).count }.by(1)

        expect(survey.reload.response_statistics[SurveyResponse.answers[:no].to_s]).to eq(no_count + 1)
      end
    end

    context "with invalid answer param" do
      let!(:typo_survey_response_params) { { answer: "yess", user_id: user.id } }

      it "doesn't create a SurveyResponse record and doesn't updates survey's counters" do
        service = described_class.new(survey_id: survey.id)

        expect do
          service.call(survey_response_params: typo_survey_response_params)
        rescue StandardError
          # handle the error in the future
        end.not_to(change { SurveyResponse.count })

        expect(survey.reload.response_statistics[SurveyResponse.answers[:yes].to_s]).to eq(yes_count)
        expect(survey.reload.response_statistics[SurveyResponse.answers[:no].to_s]).to eq(no_count)
      end
    end

    context "with no user_id param" do
      let!(:authorless_survey_response_params) { { answer: "yes" } }

      it "doesn't create a SurveyResponse record and doesn't updates survey's counters" do
        service = described_class.new(survey_id: survey.id)

        expect do
          service.call(survey_response_params: authorless_survey_response_params)
        rescue StandardError
          # handle the error in the future
        end.not_to(change { SurveyResponse.count })

        expect(survey.reload.response_statistics[SurveyResponse.answers[:yes].to_s]).to eq(yes_count)
        expect(survey.reload.response_statistics[SurveyResponse.answers[:no].to_s]).to eq(no_count)
      end
    end
  end
end
