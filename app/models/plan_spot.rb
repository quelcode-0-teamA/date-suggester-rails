class PlanSpot < ApplicationRecord
  validates :plan_id, numericality: true
  validates :spot_id, numericality: true
  validates :order, numericality: true

  belongs_to :spot
  belongs_to :plan
  scope :sum_budget, -> { includes(:spot).inject(0) { |sum, plan| sum + plan.spot[:budget] } }

  def self.add_spot(plan, spot, order)
    data = plan.plan_spots.new(spot)
    data.save(order: order)
  end
end
