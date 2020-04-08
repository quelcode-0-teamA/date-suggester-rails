module V1
  class SpotsController < ApplicationController
    # GET /v1/spots/:id(.:format)
    def show
      render json: Spot.find(params[:id])
    end
  end
end
