# == Schema Information
#
# Table name: areas
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  order      :integer          default("0"), not null
#  region     :integer          default("0"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_areas_on_order  (order)
#
FactoryBot.define do
  factory :area do
    name { '新宿' }
    sequence(:order) { |n| n }
  end
end
