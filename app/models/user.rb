class User < ApplicationRecord
  has_secure_token
  # PasswordのVaridatesをupdate時のみにする
  has_secure_password validations: false
  validate(on: :update) do |record|
    record.errors.add(:password, :blank) if record.password_digest.blank?
  end
  validates :password, on: :update, confirmation: { allow_blank: true },
                       length: { maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED }

  validates :name, length: { maximum: 20 }
  before_save { self.email = email&.downcase }
  validates :email, on: :update, presence: true, length: { maximum: 255 },
                    uniqueness: { case_sensitive: false }

  validates :birth_year, numericality: true

  belongs_to :area
  has_many :my_plans
end
