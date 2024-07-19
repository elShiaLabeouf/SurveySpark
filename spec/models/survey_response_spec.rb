# frozen_string_literal: true

require "rails_helper"

describe SurveyResponse, type: :model do
  describe "attributes" do
    it { is_expected.to define_enum_for(:answer).with_values(%i[yes no]) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:survey) }
    it { is_expected.to belong_to(:user) }
  end
end
