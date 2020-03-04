# == Schema Information
#
# Table name: date_types
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class DateType < ApplicationRecord
  validates :name, presence: true
end
