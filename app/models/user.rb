# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  birth_year      :integer          not null
#  email           :string
#  gender          :integer
#  name            :string
#  password_digest :string
#  token           :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  area_id         :bigint           not null
#
# Indexes
#
#  index_users_on_area_id  (area_id)
#  index_users_on_email    (email) UNIQUE
#  index_users_on_token    (token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (area_id => areas.id)
#
class User < ApplicationRecord
  include Rails.application.routes.url_helpers

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  has_secure_token
  has_one_attached :avatar
  has_many :my_plans, dependent: :destroy
  belongs_to :area

  enum gender: { unknown: 0, male: 1, female: 2 }

  # PasswordのValidationsをUpdate時のみ実行
  has_secure_password validations: false
  validates :password, on: :update, confirmation: { allow_blank: true },
                       length: { maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED }
  validates :password_digest, on: :update, presence: true
  validates :name, length: { in: 2..20 }, allow_nil: true
  validates :email, on: :update, presence: true, length: { maximum: 255 },
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX }
  validates :birth_year, numericality: { in: 1900..Time.zone.today.year }

  before_save { self.email = email&.downcase }

  def avatar_url
    avatar.attached? ? url_for(avatar) : nil
  end
end
