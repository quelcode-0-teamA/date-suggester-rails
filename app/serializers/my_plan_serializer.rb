class MyPlanSerializer < ActiveModel::Serializer
    attributes  :id,
                :plan

    def plan
        PlanDitailSerializer.new(object.plan)
    end
end
