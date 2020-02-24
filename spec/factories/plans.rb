FactoryBot.define do
  factory :plan do
    title { '映画デート' }
    description { '新宿でまったりと映画デート♪' }
    total_budget { 2500 }
    trait :with_area do
      area
    end
  end
end
