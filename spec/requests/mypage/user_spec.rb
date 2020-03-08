require 'rails_helper'
require 'application_helper'

RSpec.describe 'User', type: :request do
  describe '/v1/mypage' do
    let(:user) { create(:user) }
    let(:area_id) { create(:area).id }
    let(:options) { { HTTP_AUTHORIZATION: "Bearer #{user.token}" } }
    describe '/user' do
      describe 'GET' do
        subject { get '/v1/mypage/user', headers: options }
        it { is_expected.to eq 200 }
        it_behaves_like 'Tokenがおかしい時', exist: true
      end
      describe 'PUT' do
        subject { put '/v1/mypage/user', headers: options, params: @params }
        before do
          @params = {
            "user": {
              "name": 'edit name',
              "email": 'edit@email.com',
              "birth_year": 2000,
              "gender": 'male',
              "area_id": area_id
            }
          }
        end
        it { is_expected.to eq 200 }
        it_behaves_like 'Tokenがおかしい時', exist: true
      end
      describe 'DELETE' do
        subject { delete '/v1/mypage/user', headers: options }
        before { user }
        it { is_expected.to eq 204 }
        it { expect { subject }.to change(User, :count).by(-1) }
        it_behaves_like 'Tokenがおかしい時', exist: true
      end
    end
  end
end
