class MyPlan < ApplicationRecord
  belongs_to :user
  belongs_to :plan

  validates :user, presence: true
  validates :plan, presence: true
end
