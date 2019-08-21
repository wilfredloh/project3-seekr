class AddInterviewToJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :jobs, :interview, :date
  end
end