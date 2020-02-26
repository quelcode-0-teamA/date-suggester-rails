module V1
  class PlansController < ApplicationController
    before_action :set_plan, only: %i[show]

    def show
      render json: @plan
    end

    private

      def set_plan
        @plan = Plan.find(params[:id])
      end
  end
end
