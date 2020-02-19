class MyPlan < ApplicationRecord
  validates :user_id, numericality: true
  validates :plan_id, numericality: true
end
