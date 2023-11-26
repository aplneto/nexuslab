class UserTableCompletion < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :about, :text
  end
end
