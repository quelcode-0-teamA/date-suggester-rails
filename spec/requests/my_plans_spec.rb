require 'rails_helper'
require 'application_helper'

RSpec.describe 'MyPlans', type: :request do
  describe '/v1/mypage' do
    let(:user) { create(:user) }
    let(:different_user) { create(:user) }
    let(:my_plan) { create(:my_plan, user_id: @user_id) }
    let(:plan_id) { my_plan.plan_id }
    let(:my_plan_id) { my_plan.id }
    before do
      @user_id = user.id
      @options = { HTTP_AUTHORIZATION: "Bearer #{user.token}" }
      my_plan
    end
    describe '/my_plans' do
      describe 'GET' do
        subject { get '/v1/mypage/my_plans', headers: @options }
        it { is_expected.to eq 200 }
        it_behaves_like 'Tokenがおかしい時', exist: true
      end
      describe 'POST' do
        subject { post '/v1/mypage/my_plans', params: params, headers: @options }
        let(:params) { { "plan": { "plan_id": plan_id } } }
        it { is_expected.to eq 201 }
        it_behaves_like 'Tokenがおかしい時', exist: true
      end
    end
    describe '/my_plans/:id' do
      describe 'GET' do
        subject { get "/v1/mypage/my_plans/#{my_plan_id}", headers: @options }
        it { is_expected.to eq 200 }
        it_behaves_like 'Tokenがおかしい時', exist: true, different: true
      end
      describe 'DELETE' do
        subject { delete "/v1/mypage/my_plans/#{my_plan_id}", headers: @options }
        it { is_expected.to eq 204 }
        it { expect { subject }.to change(MyPlan, :count).by(-1) }
        it_behaves_like 'Tokenがおかしい時', exist: true, different: true
      end
    end
  end
end
