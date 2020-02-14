class PlanSpot < ApplicationRecord
  validates :plan_id, numericality: true
  validates :spot_id, numericality: true
  validates :order, numericality: true

  belongs_to :spot

  def self.add_spot(plan, spot, order)
    data = plan.plan_spots.new(spot)
    data.save(order: order)
  end
end
