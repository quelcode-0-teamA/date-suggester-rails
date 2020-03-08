require 'rails_helper'
require 'application_helper'

RSpec.describe 'Top', type: :request do
  describe '/ GET' do
    subject { get '/' }
    it { is_expected.to eq 200 }
  end
end
