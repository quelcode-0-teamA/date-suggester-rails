class MyPlansSerializer < ActiveModel::Serializer
  attributes  :id,
              :plan

  def plan
    PlanSimpleSerializer.new(object.plan)
  end
end
