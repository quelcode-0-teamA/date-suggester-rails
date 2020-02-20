module V1
  module Mypage
    class MyPlansController < ApplicationController
      before_action :authorize!
      before_action :set_myplan, only: %i[show destroy]

      def index
        my_plans = @current_user.my_plans
        render_collection_serializer(my_plans, MyPlanSerializer)
      end

      def create
        my_plan = @current_user.my_plans.create!(plan_id: plan_params[:plan_id])
        render_serializer(my_plan, MyPlanSerializer)
      end

      def show
        render_serializer(@my_plan, MyPlanSerializer)
      end

      def destroy
        @my_plan.destroy!
        render json: { 'message': 'デートプランを削除しました' }
      end

      private

        def set_my_plan
          @my_plan = MyPlan.find(params[:id])
        end

        def plan_params
          params.require(:plan).permit(:plan_id)
        end
    end
  end
end
