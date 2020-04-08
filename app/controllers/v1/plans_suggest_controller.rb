module V1
  class PlansSuggestController < ApplicationController
    before_action :authorize!

    # GET /v1/plans/suggest(.:format)
    def show
      render json: PlanSuggest.suggest!(suggest_params)
    end

    private

      def suggest_params
        request.query_parameters
               .merge({ user_area: @current_user.area_id, birth_year: @current_user.birth_year })
      end
  end
end
