class Specials < ActiveRecord::Migration[6.0]
  def change
    create_table :specials do |t|
      t.string :result
      t.string :mode
      t.integer :jobs_applied_on_start
      t.integer :total_jobs_applied
      t.string :time_taken
      t.timestamps
      t.references :user
    end
  end
end