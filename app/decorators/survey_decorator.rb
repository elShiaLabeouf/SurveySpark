# frozen_string_literal: true

class SurveyDecorator < Draper::Decorator
  delegate_all

  def answers
    @answers ||= SurveyResponse.answers.map do |answer_text, answer_enum|
      value = value_by_answer_type(answer_enum)
      {
        answer_type: answer_text,
        numeric_value: numeric_data(value),
        truncated_numeric_value: truncated_numeric_data(value),
        is_truncated: counter_truncated?(value),
        percentage_value: percentage_data(value),
        share_value: percentage_data(value).sub("%", "")
      }
    end
  end

  private

  def percentage_data(value)
    return NumberFormatter.format_percentage(0) if total_responses.zero?

    NumberFormatter.format_percentage(value.to_f / total_responses * 100)
  end

  def numeric_data(value)
    "(#{NumberFormatter.with_delimiter(value)})"
  end

  def truncated_numeric_data(value)
    "(#{NumberFormatter.truncated(value)})"
  end

  def counter_truncated?(value)
    NumberFormatter.truncatable?(value)
  end

  def value_by_answer_type(answer_type_int)
    survey.response_statistics[answer_type_int.to_s] || 0
  end

  def total_responses
    @total_responses ||= response_statistics.values.sum
  end
end
