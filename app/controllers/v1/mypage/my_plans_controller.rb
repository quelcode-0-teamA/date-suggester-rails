module V1
  module Mypage
    class MyPlansController < ApplicationController
      before_action :authorize!
      before_action :current_user?, only: %i[show destroy]

      def index
        my_plans = @current_user.my_plans.recent.includes(plan: :area)
        render json: my_plans, each_serializer: MyPlansSerializer
      end

      def create
        my_plan = @current_user.my_plans.create!(plan_id: plan_params[:plan_id])
        render json: my_plan, status: :created
      end

      def show
        render json: MyPlan.find(params[:id])
      end

      def destroy
        my_plan = MyPlan.find(params[:id])
        head :no_content if my_plan.destroy!
      end

      private

        def current_user?
          my_plan = MyPlan.find(params[:id])
          render_403 unless my_plan.user == @current_user
        end

        def plan_params
          params.require(:plan).permit(:plan_id)
        end
    end
  end
end
