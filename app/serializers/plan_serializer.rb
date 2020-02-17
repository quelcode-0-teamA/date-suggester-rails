class PlanSerializer < ActiveModel::Serializer
    attributes  :id,
                :title,
                :description,
                :area_id
end
