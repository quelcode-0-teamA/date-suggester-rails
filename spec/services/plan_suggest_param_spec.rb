require 'rails_helper'
require 'application_helper'

RSpec.describe 'PlanSuggestParam', type: :service do
  describe 'Params' do
    let(:plan_suggest_param) { build(:plan_suggest_param) }
    it 'shold be valid' do
      expect(plan_suggest_param).to be_valid
    end
    describe 'validate時' do
      let(:param_validation) { plan_suggest_param.valid? }
      let(:age) { 20 }
      let(:tens_place_age) { 2 }
      let(:early_or_late) { 0 }
      let(:user_region) { Area.get_region_id(plan_suggest_param.user_area) }
      it 'tens_place_ageが挿入され値が正常' do
        param_validation
        expect(plan_suggest_param.tens_place_age).to eq tens_place_age
      end
      it 'early_or_lateが挿入され値が正常' do
        param_validation
        expect(plan_suggest_param.early_or_late).to eq early_or_late
      end
      it 'regionが挿入され値が正常' do
        param_validation
        expect(plan_suggest_param.user_region).to eq user_region
      end
      describe 'date_budgetが' do
        let(:standard_budget) { UserType.get_standard_budget(tens_place_age, early_or_late) }
        context '0の時' do
          let(:low_budget) { (standard_budget * 0).round }
          it 'low_budgetが挿入され値が正常' do
            plan_suggest_param.date_budget = 0
            param_validation
            expect(plan_suggest_param.low_budget).to eq low_budget
          end
        end
        context '1の時' do
          let(:low_budget) { (standard_budget * 0.7).round }
          it 'low_budgetが挿入され値が正常' do
            plan_suggest_param.date_budget = 1
            param_validation
            expect(plan_suggest_param.low_budget).to eq low_budget
          end
        end
        context '2の時' do
          let(:low_budget) { (standard_budget * 1.6).round }
          it 'low_budgetが挿入され値が正常' do
            plan_suggest_param.date_budget = 2
            param_validation
            expect(plan_suggest_param.low_budget).to eq low_budget
          end
        end
      end
    end
  end
end
