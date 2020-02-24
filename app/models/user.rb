class User < ApplicationRecord
  has_secure_token
  # PasswordのVaridatesをupdate時のみにする
  has_secure_password validations: false
  validate(on: :update) do |record|
    record.errors.add(:password, :blank) if record.password_digest.blank?
  end
  validates :password, on: :update, length: { maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED }
  validates :password, on: :update, confirmation: { allow_blank: true }

  validates :name, length: { maximum: 20 }
  before_save { self.email = email&.downcase }
  validates :email, uniqueness: { case_sensitive: false },
                    length: { maximum: 255 }
  validates :email, on: :update, presence: true
  validates :birth_year, numericality: true

  belongs_to :area
  has_many :my_plans
end
