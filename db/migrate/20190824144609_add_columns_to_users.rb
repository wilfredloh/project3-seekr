class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :mode, :string
    add_column :users, :start_time, :string
  end
end