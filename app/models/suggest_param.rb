class SuggestParam
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :date_area, :integer
  attribute :date_budget, :integer
  attribute :date_time, :integer
  attribute :date_type, :integer
  attribute :user_area, :integer
  attribute :birth_year, :integer

  validates :date_area, numericality: { in: 0..1 }
  validates :date_budget, numericality: { in: 0..2 }
  validates :date_time, numericality: { in: 0..2 }
  validates :date_type, numericality: { only_integer: true }
  validates :user_area, numericality: { only_integer: true }
  validates :birth_year, numericality: { in: 1900..Time.zone.today.year }
end
