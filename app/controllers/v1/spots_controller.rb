module V1
  class SpotsController < ApplicationController
    def show
      render json: Spot.find(params[:id])
    end
  end
end
