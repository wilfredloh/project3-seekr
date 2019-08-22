class Documents < ActiveRecord::Migration[6.0]
  def change
    create_table :documents do |t|
      t.string :title
      t.string :doc_type
      t.string :file
      t.string :url
      t.references :user
      t.timestamps
      end
    end
end