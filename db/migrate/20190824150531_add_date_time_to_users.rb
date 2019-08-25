class AddDateTimeToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :start_special, :datetime
  end
end