class PlanSerializer < ActiveModel::Serializer
  attributes  :id,
              :title,
              :description,
              :area_id,
              :total_budget

  def total_budget
    "#{object.total_budget.to_s(:delimited, delimiter: ',')}円"
  end
end
