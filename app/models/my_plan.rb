class MyPlan < ApplicationRecord
  validates :user_id, numericality: true
  validates :plan_id, numericality: true

  belongs_to :user
  belongs_to :plan
end
