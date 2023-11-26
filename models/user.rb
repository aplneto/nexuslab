class User < ActiveRecord::Base
    validates :email, uniqueness: true
    validates :email, presence: true
    validates :email, length: { maximum: 100 }

    validates :name, presence: true
    validates :name, length: { maximum: 200 }

    validates :username, uniqueness: true
    validates :username, presence: true
    validates :username, length: { maximum: 20 }

    validates :password, presence: true
    validates :password, length: { maximum: 32 }

    has_many :projects
    has_many :invitations
    has_many :invites, through: :invitations, source: :project
end