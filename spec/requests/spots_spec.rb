require 'rails_helper'
require 'application_helper'

RSpec.describe 'Spots', type: :request do
  describe '/v1' do
    let(:user) { create(:user, :with_area) }
    let(:spot) { create(:spot) }
    let(:set_not_exist_id) { @spot_id = 0 }
    before do
      @spot_id = spot.id
      @options = { HTTP_AUTHORIZATION: "Bearer #{user.token}" }
    end
    describe '/spots/:id' do
      describe 'GET'do
        subject { get "/v1/spots/#{@spot_id}", headers: @options }
        it { is_expected.to eq 200 }
        it_behaves_like ':idがおかしい時', exist: true
      end
    end
  end
end
