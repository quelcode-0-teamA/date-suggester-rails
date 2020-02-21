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

  factory :temp_user, class: User do
    birth_year { 1999 }
    trait :with_area do
      area
    end
  end

  factory :formal_user, class: User do
    sequence(:email) { |n| "factory-#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :area, class: Area do
    name { "東京" }
  end
end
