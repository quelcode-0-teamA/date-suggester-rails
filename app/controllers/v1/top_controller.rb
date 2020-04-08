module V1
  class TopController < ApplicationController
    # root GET /
    def index
      render json: { 'welcome!': 'APIサーバー元気に稼働中' }.to_json
    end
  end
end
