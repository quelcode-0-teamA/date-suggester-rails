module V1
  class AreasController < ApplicationController
    # GET /v1/areas(.:format)
    def index
      render json: Area.with_active.order(:order)
    end
  end
end
