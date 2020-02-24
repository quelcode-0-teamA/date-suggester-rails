FactoryBot.define do
  factory :plan_spot do
    plan
    spot
    sequence(:order) { |n| n }
  end
end
