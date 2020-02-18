require 'rails_helper'
require 'application_helper'

RSpec.describe 'Plans', type: :request do
    describe 'get /v1/plans/{plan_id}' do
        before do
          get '/v1/plans/{plan_id}'
        end
        #it 'response is ok' do
        #  expect(response).to be_ok
        #end
        #it "returns nil test" do
        #  body = JSON.parse(response.body)
        #  expect(body["message"]).to eq nil
        #end
    end
end
