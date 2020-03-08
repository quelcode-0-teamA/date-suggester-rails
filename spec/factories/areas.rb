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
#  index_areas_on_order   (order)
#  index_areas_on_region  (region)
#
FactoryBot.define do
  factory :area do
    name { '新宿' }
    region { 'shinjuku_region' }
    sequence(:order) { |n| n }
  end
end
