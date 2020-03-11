module V1
  class PlansController < ApplicationController
    # GET /v1/plans/:id(.:format)
    def show
      render json: Plan.find(params[:id])
    end
  end
end
