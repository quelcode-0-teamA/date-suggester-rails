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
FactoryBot.define do
  factory :user_type do
  end
end
