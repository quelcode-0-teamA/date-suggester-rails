# == Schema Information
#
# Table name: plans
#
#  id           :bigint           not null, primary key
#  description  :string           not null
#  thumb        :string           default("https://date-suggester.s3-ap-northeast-1.amazonaws.com/plan_default.jpg"), not null
#  title        :string           not null
#  total_budget :integer          default("0"), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  area_id      :bigint           not null
#
# Indexes
#
#  index_plans_on_area_id       (area_id)
#  index_plans_on_total_budget  (total_budget)
#
# Foreign Keys
#
#  fk_rails_...  (area_id => areas.id)
#
class Plan < ApplicationRecord
  has_many :plan_spots, dependent: :destroy
  has_many :my_plans, dependent: :destroy
  belongs_to :area

  validates :title, length: { in: 2..20 }
  validates :description, length: { in: 2..60 }
  validates :thumb, format: URI.regexp(%w[http https])
  validates :total_budget, numericality: { only_integer: true }

  class << self
    def suggest!(params)
      budget_range = UserType.calculation_budget_range(params.birth_year, params.date_budget)
      user_region = Area.get_region_id(params.user_area)
      sort_plans = sort(budget_range, params.date_area, user_region)
      sort_plans = re_sort(budget_range, params.date_area, user_region) if sort_plans.blank?
      sort_plans.sample.presence || raise(ActiveRecord::RecordNotFound, '検索結果が見つかりませんでした。')
    end

    private

      def sort(budget_range, date_area, user_region)
        areas = Area.get_date_areas(user_region, date_area)
        Plan.where(total_budget: budget_range[0]...budget_range[1])
            .where(area: areas)
      end

      def re_sort(budget_range, date_area, user_region)
        count_num = 0
        sort_plans = []
        while sort_plans.blank?
          break [] if count_num >= Area::REGION_MAX_ID

          count_num += 1
          user_region = Area.increase_region_id(user_region, count_num)
          sort_plans = sort(budget_range, date_area, user_region)
          return sort_plans if sort_plans.present?

          count_num += 1
          user_region = Area.reduce_region_id(user_region, count_num)
          sort_plans = sort(budget_range, date_area, user_region)
          return sort_plans if sort_plans.present?
        end
      end
  end
end
