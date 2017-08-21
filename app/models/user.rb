class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, uniqueness: true, allow_blank: false
  validates :encrypted_password, presence: true, uniqueness: true, allow_blank: false, format: { :with => email_regex }
  validates :firstname, presence: true, allow_blank: false
  validates :lastname, presence: true, allow_blank: false
  validates :adress, presence: true, allow_blank: false
  validates :phonenumber, presence: true, allow_blank: false
  validates :cleaner, presence: true, allow_blank: false

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
