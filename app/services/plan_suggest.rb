class PlanSuggest
  class << self
    def suggest!(params)
      suggest_params = suggest_params(params)
      sort_plans = sort(
        suggest_params.low_budget,
        suggest_params.high_budget,
        suggest_params.date_area,
        suggest_params.user_region,
        suggest_params.my_plans_id
      )
      if sort_plans.blank?
        sort_plans = re_sort(
          suggest_params.low_budget,
          suggest_params.high_budget,
          suggest_params.date_area,
          suggest_params.user_region,
          suggest_params.my_plans_id
        )
      end
      sort_plans.sample.presence || raise(ActiveRecord::RecordNotFound, '検索結果が見つかりませんでした。')
    end

    private

      def suggest_params(params)
        suggest_params = PlanSuggestParam.new(params)
        suggest_params if suggest_params.valid?
      end

      def sort(low_budget, high_budget, date_area, user_region, my_plans_id)
        areas = Area.get_date_areas(user_region, date_area)
        Plan.where(total_budget: low_budget...high_budget)
            .where(area: areas)
            .where.not(id: my_plans_id)
            .preload(:area)
      end

      def re_sort(low_budget, high_budget, date_area, user_region, my_plans_id)
        sort_plans = []
        max = (Area::REGION_MAX_ID / 2.0).round
        (1..max).each do |count_num|
          increase_region = Area.increase_region_id(user_region, count_num)
          sort_plans = sort(low_budget, high_budget, date_area, increase_region, my_plans_id)
          break if sort_plans.present?

          reduce_region = Area.reduce_region_id(user_region, count_num)
          sort_plans = sort(low_budget, high_budget, date_area, reduce_region, my_plans_id)
          break if sort_plans.present?
        end
        sort_plans
      end
  end
end
