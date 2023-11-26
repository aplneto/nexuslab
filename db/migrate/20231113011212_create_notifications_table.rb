class CreateNotificationsTable < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.string :title, :limit => 100, null:false
      t.text :body
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end

    add_reference :notifications, :user

  end
end
