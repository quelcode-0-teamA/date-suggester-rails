class Spot < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :budget, numericality: { only_integer: true }
end
