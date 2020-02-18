class SuggestPlanSerializer < ActiveModel::Serializer
  attributes  :id,
              :title,
              :total_budget,
              :description,
              :area,
              :spots

    def area
      Area.find(object.area_id).name
    end
    def spots
        spots = object.plan_spots.includes(:spot).map(&:spot)
        ActiveModel::Serializer::CollectionSerializer.new(
          spots, serializer: SpotSimpleSerializer
        )
    end
end
