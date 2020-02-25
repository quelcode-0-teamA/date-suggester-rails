require 'rails_helper'

RSpec.describe Spot, type: :model do
  let(:spot) { build(:spot) }
  describe 'Validates' do
    it 'shold be valid' do
      expect(spot).to be_valid
    end
  end
end
