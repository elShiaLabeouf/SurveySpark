# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Surveys", type: :request do
  describe "POST /surveys" do
    let(:valid_attributes) { { content: "This is a survey" } }
    let(:invalid_attributes) { { content: nil } }

    context "with valid params" do
      it "creates a new Survey" do
        expect do
          post surveys_path, params: { survey: valid_attributes }, headers: { "Accept" => "text/vnd.turbo-stream.html" }
          expect(response).to have_http_status(:ok)
        end.to change(Survey, :count).by(1)

        expect(Survey.last.content).to eq(valid_attributes[:content])
      end
    end

    context "with invalid params" do
      it "does not create a new Survey" do
        expect do
          post surveys_path, params: { survey: invalid_attributes }, headers: { "Accept" => "text/vnd.turbo-stream.html" }
          expect(response).to have_http_status(:unprocessable_content)
        end.not_to change(Survey, :count)
      end
    end
  end
end
