module V1
  module Mypage
    class MyPlansController < ApplicationController
      before_action :authorize!
      before_action :set_my_plan, only: %i[show destroy]
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
        render json: @my_plan
      end

      def destroy
        @my_plan.destroy!
        render status: :no_content
      end

      private

        def set_my_plan
          @my_plan = MyPlan.find(params[:id])
        end

        def current_user?
          render_403 unless @my_plan.user_id == @current_user.id
        end

        def plan_params
          params.require(:plan).permit(:plan_id)
        end
    end
  end
end
