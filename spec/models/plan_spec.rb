require 'rails_helper'

RSpec.describe Plan, type: :model do
  let(:plan) { build(:plan) }
  describe 'Validates' do
    it 'shold be valid' do
      expect(plan).to be_valid
    end
  end
end
