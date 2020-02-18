require 'rails_helper'

RSpec.describe Plan, type: :model do
    let(:plan) do
        FactoryBot.build(:plan)
    end
end
