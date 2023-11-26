class Project < ActiveRecord::Base
    belongs_to :user
    has_many :invitations
    has_many :guests, through: :invitations, source: :user

    has_many :files

    validates :title, presence: true
    validates :user_id, presence: true
    validates :title, uniqueness: { 
        scope: :user_id
     }
end