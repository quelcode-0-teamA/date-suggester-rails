# == Schema Information
#
# Table name: my_plans
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  plan_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_my_plans_on_plan_id  (plan_id)
#  index_my_plans_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (plan_id => plans.id)
#  fk_rails_...  (user_id => users.id)
#
class MyPlan < ApplicationRecord
  belongs_to :user
  belongs_to :plan
end
