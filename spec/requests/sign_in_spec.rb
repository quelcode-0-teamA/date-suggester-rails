require 'rails_helper'
require 'application_helper'

RSpec.describe 'Sign_in', type: :request do
  describe '/v1' do
    describe '/sign_in POST' do
      subject { post '/v1/sign_in', params: params }
      let!(:user) { User.create(sign_up_params) }
      let(:area_id) { create(:area).id }
      let(:sign_up_params) { attributes_for(:user, area_id: area_id) }
      let(:params) do
        { "user": {
          "email": sign_up_params[:email],
          "password": sign_up_params[:password]
        } }
      end
      it { is_expected.to eq 200 }
      context 'paramsが異なる時' do
        it '異なるemailはUnauthorized' do
          params[:user][:email] = 'wrong@example.com'
          expect(subject).to eq 401
        end
        it '異なるpasswordはUnauthorized' do
          params[:user][:password] = 'wrongpassword'
          expect(subject).to eq 401
        end
      end
    end
  end
end
