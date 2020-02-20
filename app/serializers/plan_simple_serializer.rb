class PlanSimpleSerializer < ActiveModel::Serializer
  attributes  :id,
              :title,
              :area,
              :total_budget

  def area
    object.area.name
  end

  def total_budget
    "#{object.total_budget.to_s(:delimited, delimiter: ',')}円"
  end
end
