class Project < ApplicationRecord
  has_many :project_users, dependent: :destroy
  has_many :users, through: :project_users
  validates :name, presence: true

  validates :project_id, presence: true
  validates :user_id, presence: true
end
