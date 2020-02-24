module V1
  class TopController < ApplicationController
    def index
      render json: { 'welcome!': 'APIサーバー元気に稼働中' }
    end
  end
end
