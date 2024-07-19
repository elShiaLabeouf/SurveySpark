# frozen_string_literal: true

require "rails_helper"

describe Survey, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:survey_responses) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:content) }
  end

  describe "#update_statistics" do
    let!(:survey) { create(:survey) }

    it "updates the json column" do
      survey.update_statistics("yes")
      expect(survey.reload.response_statistics[SurveyResponse.answers[:yes].to_s]).to eq 1
      expect(survey.reload.response_statistics[SurveyResponse.answers[:no].to_s]).to eq nil

      survey.update_statistics("yes")
      expect(survey.reload.response_statistics[SurveyResponse.answers[:yes].to_s]).to eq 2
      expect(survey.reload.response_statistics[SurveyResponse.answers[:no].to_s]).to eq nil

      survey.update_statistics("no")
      expect(survey.reload.response_statistics[SurveyResponse.answers[:yes].to_s]).to eq 2
      expect(survey.reload.response_statistics[SurveyResponse.answers[:no].to_s]).to eq 1
    end
  end
end
