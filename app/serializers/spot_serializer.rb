class SpotSerializer < ActiveModel::Serializer
  attributes  :id,
              :name,
              :description,
              :budget,
              :thumb,
              :tel,
              :url

  def budget
    "#{object.budget.to_s(:delimited, delimiter: ',')}円"
  end
end
