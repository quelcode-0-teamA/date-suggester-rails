require 'rails_helper'
require 'application_helper'

RSpec.describe 'TempUserSignUp', type: :request do
  describe '/v1' do
    describe '/temp_sign_up POST' do
      subject { post '/v1/temp_user/sign_up', params: { "temp_user": params } }
      let(:area_id) { create(:area).id }
      let(:params) { attributes_for(:temp_user, area_id: area_id) }
      it { is_expected.to eq 201 }
      it { expect { subject }.to change(User, :count).by(+1) }
    end
  end
end
