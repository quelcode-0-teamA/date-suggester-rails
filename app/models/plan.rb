class Plan < ApplicationRecord
  has_many :plan_spots

  def recalculation_total_budget
    sum = 0
    plan_spots.each { |i| sum += i.spot[:budget] }
    update(total_budget: sum)
  end

  def self.suggest(params)
    budget_range = get_date_budget(params)
    sort_params = {
      budget_range: budget_range,
      date_area: params[:date_area],
      date_time: params[:date_time],
      date_type: params[:date_type]
    }
    sorted_plans = sort_plans(sort_params)
    sorted_plans.sample
  end

  def self.sort_plans(sort_params)
    Plan.where(total_budget: sort_params[:budget_range][0]...sort_params[:budget_range][1])
        .where(area_id: sort_params[:date_area])
  end

  def self.get_date_budget(params)
    tens_place_age, early_or_late = trans_age(params[:birth_year].to_i)
    standard_budget = UserType.get_budget(tens_place_age, early_or_late)
    date_budget(standard_budget, params[:date_budget].to_i)
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
    end
  end
  private_class_method :get_date_budget, :trans_age, :date_budget
end
