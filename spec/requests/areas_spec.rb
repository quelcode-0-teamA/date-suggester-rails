require 'rails_helper'
require 'application_helper'

RSpec.describe 'Areas', type: :request do
  describe '/v1' do
    let!(:area) { create(:area) }
    describe '/areas' do
      describe 'GET' do
        subject { get '/v1/areas' }
        it { is_expected.to eq 200 }
      end
    end
  end
end
