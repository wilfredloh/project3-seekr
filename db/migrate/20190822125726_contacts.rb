class Contacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :title
      t.string :company
      t.string :phone
      t.string :email

      t.references :user
      t.timestamps
      end
  end
end