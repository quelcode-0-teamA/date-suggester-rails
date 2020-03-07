module V1
  class DateSuggestsController < ApplicationController
    before_action :authorize!

    def suggest
      render json: Plan.suggest(suggest_params)
    end

    private

      def suggest_params
        suggest_params = SuggestParam.new(request.query_parameters)
        suggest_params.attributes = {
          user_area: @current_user.area_id,
          birth_year: @current_user.birth_year
        }
        suggest_params if suggest_params.valid?
      end
  end
end
