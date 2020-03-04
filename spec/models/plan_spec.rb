# == Schema Information
#
# Table name: plans
#
#  id           :bigint           not null, primary key
#  description  :string           not null
#  thumb        :string           default("https://date-suggester.s3-ap-northeast-1.amazonaws.com/plan_default.jpg"), not null
#  title        :string           not null
#  total_budget :integer          default("0"), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  area_id      :bigint           not null
#
# Indexes
#
#  index_plans_on_area_id       (area_id)
#  index_plans_on_total_budget  (total_budget)
#
# Foreign Keys
#
#  fk_rails_...  (area_id => areas.id)
#
require 'rails_helper'

RSpec.describe Plan, type: :model do
  let(:plan) { build(:plan) }
  describe 'Validates' do
    it 'shold be valid' do
      expect(plan).to be_valid
    end
  end
end
