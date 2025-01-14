class NumberFormatter
  class << self
    include ActionView::Helpers::NumberHelper
    TRUNCATE_THRESHOLD = 10_000_000_000

    def format_percentage(number)
      formatted = format("%.2f%%", number)
      formatted.sub(/\.00%$/, "%")
    end

    def truncated(number)
      formatted_number = with_delimiter(number)
      return formatted_number unless truncatable?(number)

      "..#{formatted_number.split(',').last(3).join(',')}"
    end

    def with_delimiter(number)
      number_with_delimiter(number)
    end

    def truncatable?(number)
      number >= TRUNCATE_THRESHOLD
    end
  end
end
