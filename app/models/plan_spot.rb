class PlanSpot < ApplicationRecord
  belongs_to :plan
  belongs_to :spot

  validates :plan, presence: true
  validates :spot, presence: true,
                   uniqueness: { scope: :plan }
  validates :order, numericality: true,
                    uniqueness: { scope: :plan }

  scope :sum_budget_for_spots, -> { includes(:spot).inject(0) { |sum, plan| sum + plan.spot[:budget] } }
end
