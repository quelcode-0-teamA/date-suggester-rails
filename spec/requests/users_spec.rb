require 'rails_helper'
require 'application_helper'

RSpec.describe 'Users', type: :request do
  context '非ログイン時' do
    describe '/ GET' do
      subject { get '/' }
      it { is_expected.to eq 200 }
    end
    describe '/v1' do
      before do
        area = FactoryBot.create(:area)
        @area_id = area.id
      end
      describe '/sign_up POST' do
        let(:params) { FactoryBot.attributes_for(:user, area_id: @area_id) }
        subject { post '/v1/sign_up', params: { "user": params } }
        let(:res_keys) { %w[name email] }
        let(:res_body) do
          subject
          JSON.parse(response.body)
        end
        it { is_expected.to eq 200 }
        it { expect { subject }.to change(User, :count).by(+1) }
      end
      describe '/login POST' do
        let(:sign_up_params) { FactoryBot.attributes_for(:user, area_id: @area_id) }
        let!(:user) { User.create(sign_up_params) }
        subject { post '/v1/login', params: @params }
        let(:res_body) do
          subject
          JSON.parse(response.body)
        end
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
          it 'wrong email bad response' do
            @params[:user][:email] = 'wrong@example.com'
            expect(subject).not_to eq 200
          end
          it 'wrong password bad response' do
            @params[:user][:password] = 'wrongpassword'
            expect(subject).not_to eq 200
          end
        end
      end
    end
  end
  context 'ログイン時' do
    describe '/v1' do
      let(:user) { FactoryBot.create(:user, :with_area) }
      let(:different_user) { FactoryBot.create(:user, :with_area) }
      let(:set_not_exist_token) { @options['HTTP_AUTHORIZATION'] = 'Bearer not_exist_token' }
      let(:set_different_token) { @options['HTTP_AUTHORIZATION'] = "Bearer #{different_user.token}" }
      let(:set_not_exist_id) { @user_id = 0 }
      let(:set_different_id) { @user_id = different_user.id }
      before do
        area = FactoryBot.create(:area)
        @area_id = area.id
        @user_id = user.id
        @options ||= {}
        @options['HTTP_AUTHORIZATION'] = "Bearer #{user.token}"
      end
      describe '/users/:id' do
        describe 'GET' do
          subject(:get_users_id) { get "/v1/users/#{@user_id}", headers: @options }
          let(:res_body) do
            get_users_id
            JSON.parse(response.body)
          end
          it { is_expected.to eq 200 }
          it_behaves_like 'Tokenがおかしい時', exist: true
          it_behaves_like ':idがおかしい時', exist: true
        end
        describe 'PUT' do
          subject(:put_users_id) do
            put "/v1/users/#{@user_id}", headers: @options, params: @params
          end
          let(:res_body) do
            put_users_id
            JSON.parse(response.body)
          end
          before do
            @params = {
              "user": {
                "name": 'edit name',
                "birth_year": 2000,
                "gender": 0,
                "area_id": @area_id,
              }
            }
          end
          it { is_expected.to eq 200 }
          it_behaves_like 'Tokenがおかしい時', exist: true, different: true
          it_behaves_like ':idがおかしい時', exist: true, different: true
        end
        describe 'DELETE' do
          subject { delete "/v1/users/#{@user_id}", headers: @options }
          it { is_expected.to eq 200 }
          it { expect { subject }.to change(User, :count).by(-1) }
          it_behaves_like 'Tokenがおかしい時', exist: true, different: true
          it_behaves_like ':idがおかしい時', exist: true, different: true
        end
      end
    end
  end
end
