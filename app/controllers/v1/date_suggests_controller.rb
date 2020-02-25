module V1
  class DateSuggestsController < ApplicationController
    before_action :authorize!

    def suggest
      suggest_params[:user_area] = @current_user.area_id
      suggest_params[:birth_year] = @current_user.birth_year
      suggest_plan = Plan.suggest(suggest_params)
      render_serializer(suggest_plan, PlanDitailSerializer)
    end

    private

      def suggest_params
        request.query_parameters
      end
  end
end
