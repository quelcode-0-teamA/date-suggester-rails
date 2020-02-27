class Plan < ApplicationRecord
  has_many :plan_spots, dependent: :destroy
  belongs_to :area

  def recalculation_total_budget
    total_budget = plan_spots.sum_budget
    update(total_budget: total_budget)
  end

  def self.suggest(params)
    budget_range = get_date_budget(params[:birth_year], params[:date_budget].to_i)
    sort_params = {
      budget_range: budget_range,
      user_area: params[:user_area],
      date_area: params[:date_area],
      date_time: params[:date_time],
      date_type: params[:date_type]
    }
    sorted_plans = sort_plans(sort_params)
    sorted_plans.sample
  end

  def self.sort_plans(sort_params)
    Plan.where(total_budget: sort_params[:budget_range][0]...sort_params[:budget_range][1])
        .where(area_id: sort_params[:user_area])
  end

  def self.get_date_budget(birth_year, date_budget)
    tens_place_age, early_or_late = trans_age(birth_year)
    standard_budget = UserType.get_budget(tens_place_age, early_or_late)
    date_budget(standard_budget, date_budget)
  end

  def self.trans_age(birth_year)
    age = Time.current.year - birth_year
    tens_place_age = age / 10
    early_or_late = age % 10 < 5 ? 0 : 1
    [tens_place_age, early_or_late]
  end

  def self.date_budget(standard_budget, date_budget)
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
  private_class_method :get_date_budget, :trans_age, :date_budget
end
