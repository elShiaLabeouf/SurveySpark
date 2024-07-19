# frozen_string_literal: true

require "rails_helper"

RSpec.describe "SurveyResponses", type: :request do
  describe "POST /survey_responses" do
    let(:user) { create(:user) }
    let(:survey) { create(:survey) }
    let(:valid_params) { { answer: "This is an answer" } }
    let(:valid_action_params) { ActionController::Parameters.new(answer: "This is an answer").permit! }
    let(:invalid_params) { { answer: nil, some_unrelated_param: "should be ignored" } }
    let(:invalid_action_params) { ActionController::Parameters.new(invalid_params.except(:some_unrelated_param)).permit! }
    let(:service_double) { instance_double(SurveyResponses::Create, call: true, survey: survey) }

    before do
      allow(User).to receive(:first).and_return(user)
      allow(SurveyResponses::Create).to receive(:new).and_return(service_double)
    end

    context "with valid params" do
      it "calls the service with correct parameters and responds with turbo stream" do
        post survey_responses_path(survey_id: survey.id),
             params: { survey_response: valid_params, survey_id: survey.id },
             headers: { "Accept" => "text/vnd.turbo-stream.html" }
        expect(SurveyResponses::Create).to have_received(:new).with(survey_id: survey.id.to_s)
        expect(service_double).to have_received(:call).with(survey_response_params: valid_action_params.merge(user_id: user.id))
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid params" do
      it "still calls the service and responds with turbo stream" do
        post survey_responses_path(survey_id: survey.id),
             params: { survey_response: invalid_params, survey_id: survey.id },
             headers: { "Accept" => "text/vnd.turbo-stream.html" }
        expect(SurveyResponses::Create).to have_received(:new).with(survey_id: survey.id.to_s)
        expect(service_double).to have_received(:call).with(survey_response_params: invalid_action_params.merge(user_id: user.id))
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
