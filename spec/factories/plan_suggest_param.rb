FactoryBot.define do
  factory :plan_suggest_param do
    date_area { 0 }
    date_time { 0 }
    date_type { 0 }
    date_budget { 0 }
    user_area { 1 }
    birth_year { Time.current.year - 20 }
  end
end
