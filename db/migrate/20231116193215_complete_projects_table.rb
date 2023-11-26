class CompleteProjectsTable < ActiveRecord::Migration[7.1]
  def change
    add_column :projects, :abstract, :string, limit: 100
  end
end
