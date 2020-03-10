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
  enum early_or_late: { early: 0, late: 1 }

  validates :tens_place_age, numericality: { in: 0...10 },
                             uniqueness: { scope: :early_or_late }
  validates :early_or_late, numericality: { in: 0..1 }
  validates :standard_budget, numericality: { in: 0..50000 }

  scope :get_standard_budget_from_user_types, lambda { |tens_place_age, early_or_late|
    where(tens_place_age: tens_place_age)
      .find_by(early_or_late: early_or_late)
      .standard_budget
  }

  class << self
    def calculation_budget_range(birth_year, date_budget)
      standard_budget = get_standard_budget(birth_year)
      to_budget_range(standard_budget, date_budget)
    end

    private

      def get_standard_budget(birth_year)
        tens_place_age, early_or_late = trans_age(birth_year)
        get_standard_budget_from_user_types(tens_place_age, early_or_late)
      end

      def trans_age(birth_year)
        age = Time.current.year - birth_year
        tens_place_age = age / 10
        early_or_late = age % 10 < 5 ? 0 : 1
        [tens_place_age, early_or_late]
      end

      def to_budget_range(standard_budget, date_budget)
        case date_budget
        when 0
          [(standard_budget * 0).round, (standard_budget * 0.7).round]
        when 1
          [(standard_budget * 0.7).round, (standard_budget * 1.6).round]
        when 2
          [(standard_budget * 1.6).round, (standard_budget * 3).round]
        else
          raise ActionController::ParameterMissing, 'date_budget の値が異常です'
        end
      end
  end
end
