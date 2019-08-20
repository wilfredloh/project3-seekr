class RecentActivity < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :description
      t.timestamps
      t.references :job
    end
  end
end