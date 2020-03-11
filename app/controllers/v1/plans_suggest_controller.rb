module V1
  class PlansSuggestController < ApplicationController
    before_action :authorize!

    # GET /v1/plans/suggest(.:format)
    def show
      render json: PlanSuggest.suggest!(suggest_params)
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
