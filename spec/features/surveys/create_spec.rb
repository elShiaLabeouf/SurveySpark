# frozen_string_literal: true

require "rails_helper"

feature "Creating a survey", type: :feature do
  let!(:user) { create(:user) }

  context "with valid question" do
    let!(:question) { "A new survey. Isn't it great?" }

    it "allows a user to create a survey", js: true do
      expect(Survey.count).to eq(0)
      visit root_path
      expect(page).to have_content("No surveys have been created yet")
      expect(page).not_to have_css("#new-survey-form")
      expect(page).not_to have_css(".fresh-survey-row", text: question)
      click_button "Create New Survey"
      expect(page).to have_css("#new-survey-form")
      expect(page).not_to have_content("Successfully created!")
      fill_in "survey[content]", with: question
      find(".btn-survey-save").click
      expect(page).to have_content("Successfully created!")
      expect(page).to have_css("#new-survey-form")
      expect(page).not_to have_css("#new-survey-form", text: question)
      expect(page).not_to have_content("No surveys have been created yet")
      find(".btn-survey-close").click
      expect(page).not_to have_css("#new-survey-form")
      within("[data-survey-id='#{Survey.last.id}']") do
        expect(page).to have_css(".survey-paragraph", text: question)
        expect(page).to have_css("form input[value='Yes']")
        expect(page).to have_css("form input[value='No']")
        expect(page).to have_css(".survey-answer-percentage", text: "Yes: 0%")
        expect(page).to have_css(".survey-answer-numeric", text: "(0)")
        expect(page).to have_css(".survey-answer-percentage", text: "No: 0%")
        expect(page).to have_css(".progress-stacked")
      end
    end
  end

  context "with invalid (blank) question" do
    let!(:question) { "" }

    it "doesn't allow a user to create a survey", js: true do
      visit root_path
      expect(page).not_to have_css("#new-survey-form")
      expect(page).not_to have_css(".fresh-survey-row", text: question)
      click_button "Create New Survey"
      expect(page).to have_css("#new-survey-form")
      expect(page).not_to have_content("Successfully created!")
      fill_in "survey[content]", with: question
      find(".btn-survey-save").click
      expect(page).not_to have_content("Successfully created!")
      expect(page).not_to have_css(".fresh-survey-row", text: question)
      expect(page).to have_css("#new-survey-form")
      expect(page).to have_css(".invalid-feedback", text: "A question shall not be blank 🙏")
    end
  end
end
