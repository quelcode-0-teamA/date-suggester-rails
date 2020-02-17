class PlanSerializer < ActiveModel::Serializer
    attributes  :id,
                :title,
                :description,
                :area,
                :budget
                :time
                :thumb
                :spots
end
