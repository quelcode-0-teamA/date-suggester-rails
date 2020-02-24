require 'rails_helper'

RSpec.describe MyPlan, type: :model do
  describe 'Validates' do
    it 'shold be valid' do
      expect(create(:my_plan)).to be_valid
    end
  end
end
