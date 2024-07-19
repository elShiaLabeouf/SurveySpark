# frozen_string_literal: true

class SurveyDecorator < Draper::Decorator
  include ActionView::Helpers::NumberHelper
  TRUNCATE_THRESHOLD = 10_000_000_000

  delegate_all

  def set_context(current_answer_type:)
    @current_answer_type_counter = value_by_answer_type(current_answer_type)
  end

  def percentage_data
    return format_percentage(0) if total_responses.zero?

    format_percentage(current_answer_type_counter.to_f / total_responses * 100)
  end

  def numeric_data(truncate: false)
    return "(#{truncated_current_answer_type_counter})" if truncate && current_answer_type_counter_truncatable?

    "(#{number_with_delimiter(current_answer_type_counter)})"
  end

  def current_answer_type_counter_truncatable?
    current_answer_type_counter >= TRUNCATE_THRESHOLD
  end

  private

  def current_answer_type_counter
    raise "Context is not set. Please use #set_context" unless @current_answer_type_counter

    @current_answer_type_counter
  end

  def value_by_answer_type(answer_type_text)
    answer_type_int = SurveyResponse.answers[answer_type_text]
    raise "Invalid answer type" unless answer_type_int

    survey.response_statistics[answer_type_int.to_s] || 0
  end

  def total_responses
    @total_responses ||= response_statistics.values.sum
  end

  def format_percentage(number)
    formatted = format("%.2f%%", number)
    formatted.sub(/\.00%$/, "%")
  end

  def truncated_current_answer_type_counter
    formatted_number = number_with_delimiter(current_answer_type_counter)
    return formatted_number unless current_answer_type_counter_truncatable?

    "..#{formatted_number.split(',').last(3).join(',')}"
  end
end
