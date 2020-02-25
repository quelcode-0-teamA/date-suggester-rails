require 'rails_helper'

RSpec.describe PlanSpot, type: :model do
  describe 'Validates' do
    it 'shold be valid' do
      expect(create(:plan_spot)).to be_valid
    end
  end
end
