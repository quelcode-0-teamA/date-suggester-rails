class PlanSuggest
  class << self
    def suggest!(params)
      suggest_params = check_suggest_params(params)
      budget_range = UserType.calculation_budget_range(suggest_params.birth_year, suggest_params.date_budget)
      user_region = Area.get_region_id(suggest_params.user_area)
      sort_plans = sort(budget_range, suggest_params.date_area, user_region)
      sort_plans = re_sort(budget_range, suggest_params.date_area, user_region) if sort_plans.blank?
      sort_plans.sample.presence || raise(ActiveRecord::RecordNotFound, '検索結果が見つかりませんでした。')
    end

    private

      def check_suggest_params(params)
        suggest_params = PlanSuggestParam.new(params)
        suggest_params if suggest_params.valid?
      end

      def sort(budget_range, date_area, user_region)
        areas = Area.get_date_areas(user_region, date_area)
        Plan.where(total_budget: budget_range[0]...budget_range[1])
            .where(area: areas)
      end

      def re_sort(budget_range, date_area, user_region)
        count_num = 0
        sort_plans = []
        while sort_plans.blank?
          break [] if count_num >= Area::REGION_MAX_ID

          count_num += 1
          user_region = Area.increase_region_id(user_region, count_num)
          sort_plans = sort(budget_range, date_area, user_region)
          return sort_plans if sort_plans.present?

          count_num += 1
          user_region = Area.reduce_region_id(user_region, count_num)
          sort_plans = sort(budget_range, date_area, user_region)
          return sort_plans if sort_plans.present?
        end
      end
  end
end
