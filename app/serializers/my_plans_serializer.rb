class MyPlansSerializer < ActiveModel::Serializer
  attribute :plan

  def plan
    PlanSimpleSerializer.new(object.plan)
  end
end