class User < ApplicationRecord
  has_secure_password validations: false
  has_secure_token
  validates :name, length: { maximum: 20 }
  before_save { self.email = email&.downcase }
  validates :email, uniqueness: { case_sensitive: false }, length: { maximum: 255 }
  validates :birth_year, numericality: true

  belongs_to :area
  has_many :my_plans
end
