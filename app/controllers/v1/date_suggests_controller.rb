module V1
  class DateSuggestsController < ApplicationController
    def suggest
      suggest_plan = Plan.suggest(suggest_params)
      render_serializer(suggest_plan, SuggestPlanSerializer)
    end

    private

      def suggest_params
        request.query_parameters
      end
  end
end
