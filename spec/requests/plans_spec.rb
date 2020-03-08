require 'rails_helper'
require 'application_helper'

RSpec.describe 'Plans', type: :request do
  describe '/v1' do
    let(:user) { create(:user) }
    let(:options) { { HTTP_AUTHORIZATION: "Bearer #{user.token}" } }
    let(:plan) { create(:plan) }
    let(:plan_id) { plan.id }
    describe '/plans/:id' do
      describe 'GET' do
        subject { get "/v1/plans/#{plan_id}", headers: options }
        it { is_expected.to eq 200 }
        context ':idが存在しない時' do
          let(:plan_id) { 0 }
          it { is_expected.to eq 404 }
        end
      end
    end
  end
end
