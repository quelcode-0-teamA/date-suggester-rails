class PlanSpot < ApplicationRecord
  validates :plan_id, numericality: true
  validates :spot_id, numericality: true
  validates :order, numericality: true
end
