require 'rails_helper'
require 'application_helper'

RSpec.describe 'Plans', type: :request do
  describe '/v1' do
    let(:user) { create(:user) }
    let(:plan) { create(:plan) }
    let(:set_not_exist_id) { @plan_id = 0 }
    before do
      @plan_id = plan.id
      @options = { HTTP_AUTHORIZATION: "Bearer #{user.token}" }
    end
    describe '/plans/:id' do
      describe 'GET'do
        subject { get "/v1/plans/#{@plan_id}", headers: @options }
        it { is_expected.to eq 200 }
        it_behaves_like ':idがおかしい時', exist: true
      end
    end
  end
end
