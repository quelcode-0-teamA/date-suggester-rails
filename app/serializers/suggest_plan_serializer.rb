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
        plan_spots = object.plan_spots
        spots = []
        plan_spots.each { |a| spots << a.spot }
        ActiveModel::Serializer::CollectionSerializer.new(
          spots, serializer: SpotSimpleSerializer
        )
    end
end
