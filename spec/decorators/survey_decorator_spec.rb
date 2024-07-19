# frozen_string_literal: true

require "rails_helper"

RSpec.describe SurveyDecorator do
  let!(:yes_count) { 37 }
  let!(:no_count) { 25 }
  let!(:survey) { create(:survey, yes_count: yes_count, no_count: no_count) }

  describe "#percentage_data" do
    it "returns the percentage of a given answer type" do
      decorated = described_class.decorate(survey)
      decorated.set_context(current_answer_type: "yes")
      expect(decorated.percentage_data).to eq "59.68%"
      decorated.set_context(current_answer_type: "no")
      expect(decorated.percentage_data).to eq "40.32%"
    end
  end

  describe "#numeric_data" do
    it "returns the numeric value of a given answer type" do
      decorated = described_class.decorate(survey)
      decorated.set_context(current_answer_type: "yes")
      expect(decorated.numeric_data).to eq "(#{yes_count})"
      decorated.set_context(current_answer_type: "no")
      expect(decorated.numeric_data).to eq "(#{no_count})"
    end

    describe "when number of responses is >= TRUNCATE_THRESHOLD (10_000_000_000)" do
      let!(:survey) { create(:survey, yes_count: 10_000_000_001, no_count: 10_000_000_000) }

      it "returns truncated numeric value with delimiters when truncate: true" do
        decorated = described_class.decorate(survey)
        decorated.set_context(current_answer_type: "yes")
        expect(decorated.numeric_data(truncate: true)).to eq "(..000,000,001)"
        decorated.set_context(current_answer_type: "no")
        expect(decorated.numeric_data(truncate: true)).to eq "(..000,000,000)"
      end

      it "returns numeric value with delimiters when truncate: false" do
        decorated = described_class.decorate(survey)
        decorated.set_context(current_answer_type: "yes")
        expect(decorated.numeric_data).to eq "(10,000,000,001)"
        decorated.set_context(current_answer_type: "no")
        expect(decorated.numeric_data).to eq "(10,000,000,000)"
      end
    end
  end

  describe "#current_answer_type_counter_truncatable?" do
    describe "when number of responses is < TRUNCATE_THRESHOLD (10_000_000_000)" do
      it "returns false" do
        decorated = described_class.decorate(survey)
        decorated.set_context(current_answer_type: "yes")
        expect(decorated.current_answer_type_counter_truncatable?).to eq false
        decorated.set_context(current_answer_type: "no")
        expect(decorated.current_answer_type_counter_truncatable?).to eq false
      end
    end

    describe "when number of responses is >= TRUNCATE_THRESHOLD (10_000_000_000)" do
      let!(:survey) { create(:survey, yes_count: 10_000_000_001, no_count: 10_000_000_000) }

      it "returns true" do
        decorated = described_class.decorate(survey)
        decorated.set_context(current_answer_type: "yes")
        expect(decorated.current_answer_type_counter_truncatable?).to eq true
        decorated.set_context(current_answer_type: "no")
        expect(decorated.current_answer_type_counter_truncatable?).to eq true
      end
    end
  end
end
