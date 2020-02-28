class Plan < ApplicationRecord
  has_many :plan_spots, dependent: :destroy
  belongs_to :area

  def recalculation_total_budget
    total_budget = plan_spots.sum_budget
    update(total_budget: total_budget)
  end

  class << self
    def suggest(params)
      sorted_plans = sort_plans(params)
      sorted_plans.sample
    end

    def sort_plans(params)
      budget_range = get_date_budget(params[:birth_year], params[:date_budget].to_i)
      areas = get_areas(params[:user_area])
      Plan.where(total_budget: budget_range[0]...budget_range[1])
          .where(area: areas)
    end

    def get_date_budget(birth_year, date_budget)
      standard_budget = get_standard_budget(birth_year)
      date_budget(standard_budget, date_budget)
    end

    def get_standard_budget(birth_year)
      tens_place_age, early_or_late = trans_age(birth_year)
      UserType.get_budget(tens_place_age, early_or_late)
    end

    def trans_age(birth_year)
      age = Time.current.year - birth_year
      tens_place_age = age / 10
      early_or_late = age % 10 < 5 ? 0 : 1
      [tens_place_age, early_or_late]
    end

    def date_budget(standard_budget, date_budget)
      case date_budget
      when 0
        [(standard_budget * 0).round, (standard_budget * 0.7).round]
      when 1
        [(standard_budget * 0.7).round, (standard_budget * 2).round]
      when 2
        [(standard_budget * 2).round, (standard_budget * 4).round]
      else
        raise ActionController::ParameterMissing, 'date_budget の値が異常です'
      end
    end

    def get_areas(user_area)
      area = Area.find(user_area)
      Area.where(region: area.region)
    end
  end
  private_class_method :get_date_budget, :trans_age, :date_budget
end
