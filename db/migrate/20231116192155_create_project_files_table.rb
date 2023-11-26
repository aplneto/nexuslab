class CreateProjectFilesTable < ActiveRecord::Migration[7.1]
  def change
    create_table :project_files, force: :cascade do |t|
      t.string :filename, :limit => 100, null: false
      t.references :project, foreign_key: true
      t.references :user, foreign_key: true
      t.text :path, null: false
    end
  end
end
