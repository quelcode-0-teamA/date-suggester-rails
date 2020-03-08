require 'rails_helper'
require 'application_helper'

RSpec.describe 'Users', type: :request do
  describe '/v1' do
    let(:area_id) { create(:area).id }
    describe '/temp_sign_up POST' do
      subject { post '/v1/temp_sign_up', params: { "temp_user": params } }
      let(:params) { attributes_for(:temp_user, area_id: area_id) }
      it { is_expected.to eq 201 }
      it { expect { subject }.to change(User, :count).by(+1) }
    end
    describe '/formal_sign_up POST' do
      subject { post '/v1/formal_sign_up', headers: options, params: { "formal_user": params } }
      let(:temp_user) { create(:temp_user) }
      let(:params) { attributes_for(:formal_user) }
      let(:options) { { HTTP_AUTHORIZATION: "Bearer #{temp_user.token}" } }
      it { is_expected.to eq 200 }
    end
    describe '/login POST' do
      subject { post '/v1/login', params: params }
      let!(:user) { User.create(sign_up_params) }
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
