class UserType < ApplicationRecord
  validates :tens_place_age, numericality: { in: 0...10 }
  validates :early_or_late, numericality: { in: 0..1 }
  validates :standard_budget, numericality: { in: 0...100000 }

  enum early_or_late: { early: 0, late: 1 }
  scope :get_budget, lambda { |tens_place_age, early_or_late|
    where(tens_place_age: tens_place_age)
      .find_by(early_or_late: early_or_late)
      .standard_budget
  }
end
