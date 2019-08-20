class AddColumnToMessages < ActiveRecord::Migration[6.0]
  def change
    def change
      add_reference :messages, :user, foreign_key: true
    end
  end
end