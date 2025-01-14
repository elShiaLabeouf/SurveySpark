module Home
  class SurveysStreamController < ApplicationController
    include ActionController::Live

    def index
      respond_to do |format|
        format.html { @new_survey = Survey.new }
        format.event_stream do
          surveys = SurveyDecorator.decorate_collection(SurveysQuery.call(params))
          send_sse(surveys)
        ensure
          response.stream.close
        end
      end
    end

    private

    def send_sse(surveys)
      total_surveys = surveys.count
      sse = SSE.new(response.stream, event: "message")
      surveys.each_with_index do |survey, index|
        table_row_html = render_to_string(partial: "home/surveys/survey_table_row", locals: { survey: survey }, formats: [:html])
        sse.write(table_row: table_row_html, is_last_row: total_surveys == index + 1)
      end
    end
  end
end
