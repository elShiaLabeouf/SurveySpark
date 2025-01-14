class SurveysQuery
  def self.call(params)
    Survey.order(created_at: :desc).limit(params[:items_per_page] || 100)
  end
end
