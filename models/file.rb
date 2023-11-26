class ProjectFile < ActiveRecord::Base
    belongs_to :project
    belongs_to :user

    validates :filename, presence: true
    validates :project_id, presence: true
    validates :user_id, presence: true
end