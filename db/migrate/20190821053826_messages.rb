class Messages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :description
      t.references :job
      t.timestamps
      t.references :user
    end
  end
end