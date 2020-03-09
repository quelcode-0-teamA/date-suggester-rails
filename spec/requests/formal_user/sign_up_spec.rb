require 'rails_helper'
require 'application_helper'

RSpec.describe 'FormalUserSignUp', type: :request do
  describe '/v1' do
    describe '/formal_sign_up POST' do
      subject { post '/v1/formal_user/sign_up', headers: options, params: { "formal_user": params } }
      let(:temp_user) { create(:temp_user) }
      let(:params) { attributes_for(:formal_user) }
      let(:options) { { HTTP_AUTHORIZATION: "Bearer #{temp_user.token}" } }
      it { is_expected.to eq 200 }
    end
  end
end
