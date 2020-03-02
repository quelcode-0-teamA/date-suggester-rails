class SpotSimpleSerializer < ActiveModel::Serializer
  attributes  :id,
              :name,
              :budget,
              :thumb

  def budget
    "#{object.budget.to_s(:delimited, delimiter: ',')}円"
  end
end
