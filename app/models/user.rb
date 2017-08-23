class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  has_many :cleanings
  has_many :cars, dependent: :destroy

  # email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # wtf ? validation on an encrypted password testing a mail regex ???

  validates :email, presence: true, uniqueness: true, allow_blank: false
  validates :encrypted_password, presence: true, uniqueness: true, allow_blank: false

  validate :require_cleaner

  def require_cleaner
    if cleaner
      unless address.present? && firstname.present? && lastname.present?
        errors.add(:cleaner, "Needs an address, a first name and a last name")
      end
    end
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
