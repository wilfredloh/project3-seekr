class AddSubmittedDateToJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :jobs, :submit_date, :datetime
  end
end