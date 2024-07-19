# frozen_string_literal: true

require "rails_helper"

feature "Answer to a survey", type: :feature do
  let!(:user) { create(:user) }
  let!(:survey) { create(:survey) }

  it "allows a user to respond to a survey", js: true do
    visit root_path
    expect(survey.survey_responses.count).to eq(0)
    click_button "Yes"
    within("[data-survey-id='#{survey.id}']") do
      expect(page).to have_css(".survey-answer-percentage", text: "Yes: 100%")
      expect(page).to have_css(".survey-answer-numeric", text: "(1)")
      expect(page).to have_css(".survey-answer-percentage", text: "No: 0%")
      expect(page).to have_css(".survey-answer-numeric", text: "(0)")
      expect(page).to have_css(".progress-stacked .progress[aria-label='Segment yes'][aria-valuenow='100']")
    end
    expect(survey.reload.survey_responses.count).to eq(1)
    expect(survey.response_statistics).to eq({ "0" => 1 })

    2.times { click_button "No" }
    4.times { click_button "Yes" }

    within("[data-survey-id='#{survey.id}']") do
      expect(page).to have_css(".survey-answer-percentage", text: "Yes: 71.43%")
      expect(page).to have_css(".survey-answer-numeric", text: "(5)")
      expect(page).to have_css(".survey-answer-percentage", text: "No: 28.57%")
      expect(page).to have_css(".survey-answer-numeric", text: "(2)")
      expect(page).to have_css(".progress-stacked .progress[aria-label='Segment yes'][aria-valuenow='71.43']")
      expect(page).to have_css(".progress-stacked .progress[aria-label='Segment no'][aria-valuenow='28.57']")
    end

    expect(survey.reload.survey_responses.count).to eq(7)
    expect(survey.response_statistics).to eq({ "0" => 5, "1" => 2 })
  end
end
