class Jobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.string :comp_name
      t.string :title
      t.string :location
      t.string :salary
      t.string :url
      t.date :deadline, default: "2010-01-01".to_date
      t.timestamps
      t.string :status
      t.string :ind
      t.integer :user_id
      t.date :interview, default: "2010-01-01".to_date
      t.text :notes
      t.integer :stat_index, default: 1
      end
    end
end