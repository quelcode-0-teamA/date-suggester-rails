class Plan < ApplicationRecord
  has_many :plan_spots, dependent: :destroy
  belongs_to :area

  validates :title, presence: true
  validates :description, presence: true
  validates :area, presence: true
  validates :total_budget, numericality: { only_integer: true }

  REGION_MAX_ID = 6
  scope :plan_sort, lambda { |budget_range, areas|
    where(total_budget: budget_range[0]...budget_range[1])
      .where(area: areas)
  }

  def add_spot(spot, order)
    plan_spots.create!(spot: spot, order: order)
  end

  def recalculation_total_budget
    total_budget = plan_spots.sum_budget_for_spots
    update!(total_budget: total_budget)
  end

  class << self
    def suggest(params)
      sorted_plans = sort_plans(params)
      sorted_plans.sample
    end

    def sort_plans(params)
      budget_range = calculation_budget_range(params[:birth_year], params[:date_budget].to_i)
      date_area = params[:date_area].to_i
      user_region = Area.find(params[:user_area]).region_before_type_cast
      sort_plans = sorted(budget_range, date_area, user_region)
      sort_plans = re_sort(budget_range, date_area, user_region) if sort_plans.blank?
      sort_plans
    end

    def sorted(budget_range, date_area, user_region)
      areas = get_areas(user_region, date_area)
      Plan.plan_sort(budget_range, areas)
    end

    def re_sort(budget_range, date_area, user_region)
      factor = 1
      sort_plans = []
      while sort_plans.blank?
        break [] if factor >= REGION_MAX_ID

        user_region + factor <= REGION_MAX_ID ? user_region += 1 : user_region = 1
        sort_plans = sorted(budget_range, date_area, user_region)
        return sort_plans if sort_plans.present?

        (user_region - (factor + 1)).positive? ? user_region -= 1 : user_region = REGION_MAX_ID
        sort_plans = sorted(budget_range, date_area, user_region)
        return sort_plans if sort_plans.present?

        factor += 2
      end
    end

    def calculation_budget_range(birth_year, date_budget)
      standard_budget = get_standard_budget(birth_year)
      to_budget_range(standard_budget, date_budget)
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

    def to_budget_range(standard_budget, date_budget)
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

    def get_areas(user_region, date_area)
      case date_area
      when 0
        Area.where(region: user_region)
      when 1
        exclusion_region = [0, user_region]
        if user_region + 1 > REGION_MAX_ID
          exclusion_region.push(1, user_region - 1)
        elsif user_region - 1 <= 0
          exclusion_region.push(REGION_MAX_ID, user_region + 1)
        else
          exclusion_region.push(user_region + 1, user_region - 1)
        end
        Area.where.not(region: exclusion_region)
      else
        raise ActionController::ParameterMissing, 'date_area の値が異常です'
      end
    end
  end
  private_class_method :sort_plans, :sorted, :re_sort, :calculation_budget_range,
                       :get_standard_budget, :trans_age, :to_budget_range, :get_areas
end
