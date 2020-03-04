require 'rails_helper'
require 'application_helper'

RSpec.describe 'Users', type: :request do
  let(:area_id) { create(:area).id }
  let(:res_body) do
    subject
    JSON.parse(response.body)
  end
  context '非ログイン時' do
    describe '/ GET' do
      subject { get '/' }
      it { is_expected.to eq 200 }
    end
    describe '/v1' do
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
        subject { post '/v1/login', params: @params }
        let!(:user) { User.create(sign_up_params) }
        let(:sign_up_params) { attributes_for(:user, area_id: area_id) }
        before do
          @params = {
            "user": {
              "email": sign_up_params[:email],
              "password": sign_up_params[:password]
            }
          }
        end
        it { is_expected.to eq 200 }
        context 'paramsが異なる時' do
          it '異なるemailはUnauthorized' do
            @params[:user][:email] = 'wrong@example.com'
            expect(subject).to eq 401
          end
          it '異なるpasswordはUnauthorized' do
            @params[:user][:password] = 'wrongpassword'
            expect(subject).to eq 401
          end
        end
      end
    end
  end
  context 'ログイン時' do
    describe '/v1' do
      let(:user) { create(:user) }
      let(:different_user) { create(:user) }
      let(:set_not_exist_id) { @user_id = 0 }
      let(:set_different_id) { @user_id = different_user.id }
      before do
        @user_id = user.id
        @options = { HTTP_AUTHORIZATION: "Bearer #{user.token}" }
      end
      # describe '/users/:id' do
      #   describe 'GET' do
      #     subject { get "/v1/users/#{@user_id}", headers: @options }
      #     it { is_expected.to eq 200 }
      #     it_behaves_like 'Tokenがおかしい時', exist: true
      #     it_behaves_like ':idがおかしい時', exist: true
      #   end
      #   describe 'PUT' do
      #     subject { put "/v1/users/#{@user_id}", headers: @options, params: @params }
      #     before do
      #       @params = {
      #         "user": {
      #           "name": 'edit name',
      #           "birth_year": 2000,
      #           "gender": 'male',
      #           "area_id": area_id,
      #         }
      #       }
      #     end
      #     it { is_expected.to eq 200 }
      #     it_behaves_like 'Tokenがおかしい時', exist: true, different: true
      #     it_behaves_like ':idがおかしい時', exist: true
      #   end
      #   describe 'DELETE' do
      #     subject { delete "/v1/users/#{@user_id}", headers: @options }
      #     it { is_expected.to eq 204 }
      #     it { expect { subject }.to change(User, :count).by(-1) }
      #     it_behaves_like 'Tokenがおかしい時', exist: true, different: true
      #     it_behaves_like ':idがおかしい時', exist: true
      #   end
      # end
    end
  end
end
