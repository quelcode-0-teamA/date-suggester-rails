# == Schema Information
#
# Table name: areas
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  order      :integer          default("0"), not null
#  region     :integer          default("0"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_areas_on_order   (order)
#  index_areas_on_region  (region)
#
class Area < ApplicationRecord
  enum region: {
    unknown: 0, ueno_region: 1, ikebukuro_region: 2,
    shinjuku_region: 3, shibuya_region: 4,
    ebisu_region: 5, tokyo_station_region: 6
  }

  validates :name, presence: true
  validates :order, numericality: { only_integer: true }

  scope :with_active, -> { where('"order" > ?', 0) }
end
