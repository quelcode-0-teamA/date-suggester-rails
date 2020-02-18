class SpotSerializer < ActiveModel::Serializer
    attributes  :id,
                :name,
                :description,
                :budget,
                :tel,
                :url
end
