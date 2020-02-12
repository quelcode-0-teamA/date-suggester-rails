class Plan < ApplicationRecord
  def self.suggest(params)
    budget_range = get_date_budget(params)
    date_area = params[:date_area]
    date_time = params[:date_time]
    date_type = params[:date_type]
    { "budget_range": budget_range, "date_area": date_area, "date_time": date_time, "date_type": date_type }
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
