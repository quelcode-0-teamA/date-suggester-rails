# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  birth_year      :integer          not null
#  email           :string
#  gender          :integer
#  name            :string
#  password_digest :string
#  token           :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  area_id         :bigint           not null
#
# Indexes
#
#  index_users_on_area_id  (area_id)
#  index_users_on_email    (email) UNIQUE
#  index_users_on_token    (token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (area_id => areas.id)
#
FactoryBot.define do
  factory :user do
    name { 'factory name' }
    sequence(:email) { |n| "factory-#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    birth_year { 1990 }
    gender { 1 }
    area
  end

  factory :temp_user, class: User do
    birth_year { 1990 }
    area
  end

  factory :formal_user, class: User do
    sequence(:email) { |n| "factory-#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
