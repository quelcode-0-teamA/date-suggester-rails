require 'rails_helper'

RSpec.describe Spot, type: :model do
    let(:spot) do
        FactoryBot.build(:spot)
    end
end
