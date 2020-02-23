FactoryBot.define do
  factory :user do
    name { 'factory name' }
    sequence(:email) { |n| "factory-#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    birth_year { 1999 }
    gender { 1 }
    trait :with_area do
      area
    end
  end

  factory :area, class: Area do
    name { "東京" }
    sequence(:order) { |n| n }
  end
end
