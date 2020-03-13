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
  REGION_MAX_ID = 6

  enum region: {
    unknown: 0, ueno_region: 1, ikebukuro_region: 2,
    shinjuku_region: 3, shibuya_region: 4,
    ebisu_region: 5, tokyo_station_region: 6
  }

  validates :name, presence: true
  validates :order, numericality: { only_integer: true }

  scope :with_active, -> { where.not(order: 0) }
  scope :get_region_id, ->(area_id) { find(area_id).region_before_type_cast }
  scope :sort_region, ->(user_region) { where(region: user_region) }
  scope :sort_other_regions, lambda { |user_region|
    exclusion_region = [0, user_region]
    if user_region + 1 > REGION_MAX_ID
      exclusion_region.push(1, user_region - 1)
    elsif user_region - 1 <= 0
      exclusion_region.push(REGION_MAX_ID, user_region + 1)
    else
      exclusion_region.push(user_region + 1, user_region - 1)
    end
    where.not(region: exclusion_region)
  }

  class << self
    def get_date_areas(user_region, date_area)
      case date_area
      when 0
        sort_region(user_region)
      when 1
        sort_other_regions(user_region)
      else
        raise ActionController::ParameterMissing, 'date_area の値が異常です'
      end
    end

    def increase_region_id(user_region, count_num)
      if user_region + count_num <= REGION_MAX_ID
        user_region + count_num
      else
        user_region + count_num - REGION_MAX_ID
      end
    end

    def reduce_region_id(user_region, count_num)
      if (user_region - count_num).positive?
        user_region - count_num
      else
        user_region - count_num + REGION_MAX_ID
      end
    end
  end
end
