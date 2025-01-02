# frozen_string_literal: true

class SurveysController < ApplicationController
  include ActionController::Live

  def index
    @new_survey = Survey.new
    @surveys = SurveyDecorator.decorate_collection(Survey.order(created_at: :desc).first(5000))
  end

  def index_stream
    @new_survey = Survey.new
    respond_to do |format|
      format.html
      format.event_stream do
        response.headers["Content-Type"] = "text/event-stream"
        response.headers["Last-Modified"] = Time.now.httpdate
        @surveys = SurveyDecorator.decorate_collection(Survey.order(created_at: :desc).first(5000))
        total_surveys = @surveys.count
        @surveys.each_with_index do |survey, index|
          sse = SSE.new(response.stream, event: "message")
          sse.write({ last_row: total_surveys == index + 1, table_row: render_to_string(partial: "surveys/survey_table_row", locals: { survey: survey }, formats: [ :html ]) })
        end
      ensure
        response.stream.close
      end
    end
  end

  def new
    @survey = Survey.new
  end

  def create
    new_survey = Survey.new(survey_params)

    if new_survey.save
      @survey_decorated = SurveyDecorator.decorate(new_survey)
      respond_to do |format|
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render("surveys/create_error",
                 locals: { new_survey: new_survey, expanded: false },
                 status: :unprocessable_entity)
        end
      end
    end
  end

  private

  def survey_params
    params.require(:survey).permit(:content)
  end
end
