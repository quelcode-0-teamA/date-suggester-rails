class User < ApplicationRecord
  has_secure_password
  has_secure_token
  validates :name, length: { maximum: 20 }
  before_save { self.email = email.downcase }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }
  validates :password_digest, presence: true
  validates :birth_year, numericality: true
  validates :gender, numericality: true

  belongs_to :area
end
