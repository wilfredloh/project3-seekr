class CreateNewTableMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :description
      t.references :job
      t.timestamps
    end
  end
end