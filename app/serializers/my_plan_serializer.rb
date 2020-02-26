class MyPlanSerializer < ActiveModel::Serializer
    attributes  :id,
                :plan

    def plan
        PlanSerializer.new(object.plan)
    end
end
