class User < ApplicationRecord
  validates :surname, presence: true
  validates :name, presence: true
  validates :email, presence: true
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  has_many :project_users, dependent: :destroy
  has_many :projects, through: :project_users

  has_secure_password
end
