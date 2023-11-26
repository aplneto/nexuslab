class CreateInvitationsTable < ActiveRecord::Migration[7.1]
  def change
    create_table :invitations do |t|
      t.references :project, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
