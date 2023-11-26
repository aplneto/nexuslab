class CreateUsersTable < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |u|
      u.string :email, :limit => 100, null: false
      u.string :name, :limit => 200, null:false
      u.string :username, :limit => 20, null: false
      u.string :password, :limit => 32, null:false
      u.boolean :is_admin, default: false
      u.string :profile_picture, :limit => 200
    end

    add_index :users, :email, unique: true
    add_index :users, :username, unique: true
  end
end
