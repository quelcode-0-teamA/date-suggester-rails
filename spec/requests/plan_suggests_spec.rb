require 'rails_helper'
require 'application_helper'

RSpec.describe 'PlanSuggests', type: :request do
  describe '/v1/mypage GET' do
    let(:user) { create(:user) }
    let(:options) { { HTTP_AUTHORIZATION: "Bearer #{user.token}" } }
    let(:params) do
      {
        "date_area": 0,
        "date_budget": 0,
        "date_time": 0,
        "date_type": 0
      }
    end
    subject { get '/v1/date-suggest', headers: options, params: params }
    it { is_expected.to eq 200 }
    describe 'date_area' do
      context '1' do
        before { params[:date_area] = 1 }
        it { is_expected.to eq 200 }
      end
    end
    describe 'date_budget' do
      context '1' do
        before { params[:date_budget] = 1 }
        it { is_expected.to eq 200 }
      end
      context '2' do
        before { params[:date_budget] = 2 }
        it { is_expected.to eq 200 }
      end
    end
    context 'birth_yearが1995の時' do
      let(:user) { create(:user, birth_year: 1995) }
      subject { get '/v1/date-suggest', headers: options, params: params }
      it { is_expected.to eq 200 }
      describe 'date_area' do
        context '1' do
          before { params[:date_area] = 1 }
          it { is_expected.to eq 200 }
        end
      end
      describe 'date_budget' do
        context '1' do
          before { params[:date_budget] = 1 }
          it { is_expected.to eq 200 }
        end
        context '2' do
          before { params[:date_budget] = 2 }
          it { is_expected.to eq 200 }
        end
      end
    end
  end
end
