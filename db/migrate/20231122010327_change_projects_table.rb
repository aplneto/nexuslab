class ChangeProjectsTable < ActiveRecord::Migration[7.1]
  def change
    change_column(:projects, :abstract, :text)
  end
end
