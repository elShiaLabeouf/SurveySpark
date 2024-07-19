class AddLockVersionToSurveys < ActiveRecord::Migration[7.1]
  def change
    add_column :surveys, :lock_version, :integer
  end
end
