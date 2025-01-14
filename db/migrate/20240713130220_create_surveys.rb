class CreateSurveys < ActiveRecord::Migration[7.1]
  def change
    create_table :surveys do |t|
      t.string :content
      t.json :response_statistics, default: {}

      t.timestamps
    end
  end
end
