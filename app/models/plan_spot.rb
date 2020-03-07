# == Schema Information
#
# Table name: plan_spots
#
#  id         :bigint           not null, primary key
#  order      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  plan_id    :bigint           not null
#  spot_id    :bigint           not null
#
# Indexes
#
#  index_plan_spots_on_plan_id              (plan_id)
#  index_plan_spots_on_plan_id_and_order    (plan_id,order) UNIQUE
#  index_plan_spots_on_plan_id_and_spot_id  (plan_id,spot_id) UNIQUE
#  index_plan_spots_on_spot_id              (spot_id)
#
# Foreign Keys
#
#  fk_rails_...  (plan_id => plans.id)
#  fk_rails_...  (spot_id => spots.id)
#
class PlanSpot < ApplicationRecord
  belongs_to :plan
  belongs_to :spot

  validates :spot, uniqueness: { scope: :plan }
  validates :order, uniqueness: { scope: :plan },
                    numericality: { only_integer: true }

  after_save :recalculation_total_budget

  scope :sum_budget_for_spots, -> { eager_load(:spot).inject(0) { |sum, plan| sum + plan.spot[:budget] } }

  def recalculation_total_budget
    plan.update(total_budget: plan.plan_spots.sum_budget_for_spots)
  end
end
