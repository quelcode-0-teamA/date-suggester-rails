class User < ApplicationRecord
  has_secure_token
  has_many :my_plans, dependent: :destroy
  belongs_to :area

  # PasswordのValidationsをUpdate時のみ実行
  has_secure_password validations: false
  validates :password, on: :update, confirmation: { allow_blank: true },
                       length: { maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED }
  validates :password_digest, on: :update, presence: true
  validates :name, length: { maximum: 20 }
  before_save { self.email = email&.downcase }
  validates :email, on: :update, presence: true, length: { maximum: 255 },
                    uniqueness: { case_sensitive: false }
  validates :birth_year, numericality: true
  enum gender: { unknown: 0, male: 1, female: 2 }
end
