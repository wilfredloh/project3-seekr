class DocumentsJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :documents_jobs do |t|
      t.references :document
      t.references :job
      t.timestamps
    end
  end
end