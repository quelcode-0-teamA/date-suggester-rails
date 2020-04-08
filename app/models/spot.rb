# == Schema Information
#
# Table name: spots
#
#  id          :bigint           not null, primary key
#  budget      :integer          not null
#  description :text             not null
#  name        :string           not null
#  tel         :integer
#  thumb       :string           default("https://date-suggester.s3-ap-northeast-1.amazonaws.com/spot_default.jpg"), not null
#  url         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Spot < ApplicationRecord
  VALID_PHONE_REGEX = /\A\d{10}$|^\d{11}\z/.freeze

  validates :name, presence: true
  validates :description, presence: true
  validates :thumb, format: URI.regexp(%w[http https])
  validates :budget, numericality: { only_integer: true }
  validates :url, format: URI.regexp(%w[http https]), allow_nil: true
  validates :tel, format: VALID_PHONE_REGEX, allow_nil: true
end
