class CreateSurveyResponses < ActiveRecord::Migration[7.1]
  def change
    create_table :survey_responses do |t|
      t.integer :survey_id
      t.integer :user_id
      t.integer :answer

      t.timestamps
    end
  end
end
