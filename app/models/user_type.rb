# == Schema Information
#
# Table name: user_types
#
#  id              :bigint           not null, primary key
#  early_or_late   :integer          not null
#  standard_budget :integer          not null
#  tens_place_age  :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_user_types_on_early_or_late                     (early_or_late)
#  index_user_types_on_tens_place_age                    (tens_place_age)
#  index_user_types_on_tens_place_age_and_early_or_late  (tens_place_age,early_or_late) UNIQUE
#
class UserType < ApplicationRecord
  validates :tens_place_age, numericality: { in: 0...10 },
                             uniqueness: { scope: :early_or_late }
  validates :early_or_late, numericality: { in: 0..1 }
  validates :standard_budget, numericality: { in: 0..50000 }
  enum early_or_late: { early: 0, late: 1 }

  scope :get_budget, lambda { |tens_place_age, early_or_late|
    where(tens_place_age: tens_place_age)
      .find_by(early_or_late: early_or_late)
      .standard_budget
  }
end
