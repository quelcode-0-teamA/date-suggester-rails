module V1
  module Mypage
    class PlansController < ApplicationController
      before_action :authorize!
      before_action :set_myplan

      def create
        myplan = MyPlan.new(user_id: @current_user.id)
        render_serializer(@myplan, MyPlanSerializer)
      end

      def show
        render_serializer(@myplan, MyPlanSerializer)
      end

      def destroy
        myplan.destroy!
        render json: { 'message': 'デートプランを削除しました' }
      end

      private

        def index
          @myplans = MyPlan.all
        end

        def set_myplan
          @myplan = MyPlan.find(params[:id])
        end

    end
  end
end
