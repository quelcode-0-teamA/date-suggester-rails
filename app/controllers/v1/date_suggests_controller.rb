module V1
  class DateSuggestsController < ApplicationController
    before_action :authorize!

    def suggest
      suggest_params[:user_area] = @current_user.area_id
      suggest_params[:birth_year] = @current_user.birth_year
      suggest_plan = Plan.suggest(suggest_params)
      if suggest_plan.blank?
        raise ActiveRecord::RecordNotFound, '検索結果が見つかりませんでした。'
      end

      render json: suggest_plan
    end

    private

      def suggest_params
        query = request.query_parameters
        query if query_checked(query)
      end

      def query_checked(query)
        keys = %i[date_area date_budget date_time date_type]
        keys.each do |key|
          unless query.key?(key)
            raise ActionController::ParameterMissing, "#{key} の必須パラメータが送られていません。"
          end
        end
      end
  end
end
