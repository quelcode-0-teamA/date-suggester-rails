# == Schema Information
#
# Table name: plan_spots
#
#  id         :bigint           not null, primary key
#  order      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  plan_id    :bigint           not null
#  spot_id    :bigint           not null
#
# Indexes
#
#  index_plan_spots_on_plan_id              (plan_id)
#  index_plan_spots_on_plan_id_and_order    (plan_id,order) UNIQUE
#  index_plan_spots_on_plan_id_and_spot_id  (plan_id,spot_id) UNIQUE
#  index_plan_spots_on_spot_id              (spot_id)
#
# Foreign Keys
#
#  fk_rails_...  (plan_id => plans.id)
#  fk_rails_...  (spot_id => spots.id)
#
FactoryBot.define do
  factory :plan_spot do
    plan
    spot
    sequence(:order) { |n| n }
  end
end
