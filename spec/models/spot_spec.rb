# == Schema Information
#
# Table name: spots
#
#  id          :bigint           not null, primary key
#  budget      :integer          not null
#  description :text             not null
#  name        :string           not null
#  tel         :integer
#  thumb       :string           default("https://date-suggester.s3-ap-northeast-1.amazonaws.com/spot_default.jpg"), not null
#  url         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Spot, type: :model do
  let(:spot) { build(:spot) }
  describe 'Validates' do
    it 'shold be valid' do
      expect(spot).to be_valid
    end
  end
end
