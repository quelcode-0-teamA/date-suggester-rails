module V1
  class DateSuggestsController < ApplicationController
    before_action :authorize!

    def suggest
      render json: Plan.suggest!(suggest_params)
    end

    private

      def suggest_params
        suggest_params = request.query_parameters
        suggest_params[:user_area] = @current_user.area_id
        suggest_params[:birth_year] = @current_user.birth_year
        suggest_params
      end
  end
end
