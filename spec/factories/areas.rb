FactoryBot.define do
  factory :area do
    name { "新宿" }
    sequence(:order) { |n| n }
  end
end
