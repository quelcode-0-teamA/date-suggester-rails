class PlanSuggestParam
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations::Callbacks

  attribute :date_area, :integer
  attribute :date_time, :integer
  attribute :date_type, :integer
  attribute :date_budget, :integer
  attribute :low_budget, :integer
  attribute :high_budget, :integer
  attribute :user_area, :integer
  attribute :user_region, :integer
  attribute :birth_year, :integer
  attribute :tens_place_age, :integer
  attribute :early_or_late, :integer
  attribute :my_plans_id, array: :integer

  validates :date_area, numericality: { in: 0..1 }
  validates :date_time, numericality: { in: 0..2 }
  validates :date_type, numericality: { only_integer: true }
  validates :date_budget, numericality: { in: 0..2 }
  validates :low_budget, numericality: { only_integer: true }
  validates :high_budget, numericality: { only_integer: true }
  validates :user_area, numericality: { only_integer: true }
  validates :user_region, numericality: { only_integer: true }
  validates :birth_year, numericality: { in: 1900..Time.zone.today.year }
  validates :tens_place_age, numericality: { only_integer: true }
  validates :early_or_late, numericality: { only_integer: true }

  before_validation :calc_age
  before_validation :region
  before_validation :calc_budget_range

  private

    def calc_age
      age = Time.current.year - birth_year
      self.tens_place_age = age / 10
      self.early_or_late = age % 10 < 5 ? 0 : 1
    end

    def region
      self.user_region = Area.get_region_id(user_area)
    end

    def calc_budget_range
      standard_budget = UserType.get_standard_budget(tens_place_age, early_or_late)
      self.low_budget, self.high_budget = to_budget_range(standard_budget, date_budget)
    end

    def to_budget_range(standard_budget, date_budget)
      case date_budget
      when 0
        [(standard_budget * 0).round, (standard_budget * 1.2).round]
      when 1
        [(standard_budget * 0.5).round, (standard_budget * 2).round]
      when 2
        [(standard_budget * 1.4).round, (standard_budget * 3).round]
      else
        raise ActionController::ParameterMissing, 'date_budget の値が異常です'
      end
    end
end
