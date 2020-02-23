class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :recent, -> { order(updated_at: :desc) }
  scope :order_asc, -> { order(order: :asc) }
end
