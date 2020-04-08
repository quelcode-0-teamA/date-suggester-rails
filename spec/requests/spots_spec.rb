require 'rails_helper'
require 'application_helper'

RSpec.describe 'Spots', type: :request do
  describe '/v1' do
    let(:user) { create(:user) }
    let(:options) { { HTTP_AUTHORIZATION: "Bearer #{user.token}" } }
    let(:spot_id) { create(:spot).id }
    describe '/spots/:id' do
      describe 'GET' do
        subject { get "/v1/spots/#{spot_id}", headers: options }
        it { is_expected.to eq 200 }
        context ':idが存在しない時' do
          let(:spot_id) { 0 }
          it { is_expected.to eq 404 }
        end
      end
    end
  end
end
