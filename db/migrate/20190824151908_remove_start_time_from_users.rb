class RemoveStartTimeFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :start_time, :string
  end
end