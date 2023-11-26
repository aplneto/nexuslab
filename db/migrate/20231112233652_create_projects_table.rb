class CreateProjectsTable < ActiveRecord::Migration[7.1]
  def change
    create_table :projects, force: :cascade do |t|
      t.string :title, :limit => 100, null: false
      t.boolean :is_public, default: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end

    add_reference :projects, :user
  end
end
