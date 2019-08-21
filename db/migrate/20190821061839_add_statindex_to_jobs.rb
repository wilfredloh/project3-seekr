class AddStatindexToJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :jobs, :stat_index, :integer, default: 1
  end
end