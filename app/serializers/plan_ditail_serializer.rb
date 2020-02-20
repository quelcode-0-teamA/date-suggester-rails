class PlanDitailSerializer < ActiveModel::Serializer
  attributes  :id,
              :title,
              :description,
              :area,
              :total_budget,
              :spots

  def area
    object.area.name
  end

  def total_budget
    "#{object.total_budget.to_s(:delimited, delimiter: ',')}円"
  end

  def spots
      spots = object.plan_spots.includes(:spot).map(&:spot)
      ActiveModel::Serializer::CollectionSerializer.new(
        spots, serializer: SpotSimpleSerializer
      )
  end
end
