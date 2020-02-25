FactoryBot.define do
  factory :user do
    name { 'factory name' }
    sequence(:email) { |n| "factory-#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    birth_year { 1999 }
    gender { 1 }
    area
  end

  factory :temp_user, class: User do
    birth_year { 1999 }
    area
  end

  factory :formal_user, class: User do
    sequence(:email) { |n| "factory-#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
