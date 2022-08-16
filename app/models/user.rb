class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :surname, presence: true
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: true }
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  has_many :project_users, dependent: :destroy
  has_many :projects, through: :project_users
end
