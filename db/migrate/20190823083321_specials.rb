class Specials < ActiveRecord::Migration[6.0]
  def change
    create_table :specials do |t|
      t.string :ongoing
      t.string :result
      t.integer :applied
      t.integer :mode
      t.timestamps
      t.references :user
    end
  end
end