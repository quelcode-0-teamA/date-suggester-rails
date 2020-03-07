module V1
  class PlansController < ApplicationController
    def show
      render json: Plan.find(params[:id])
    end
  end
end
