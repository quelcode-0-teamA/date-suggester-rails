module V1
  class MyPlansController < ApplicationController
    before_action :authorize!

    # GET /v1/my_plans(.:format)
    def index
      my_plans = @current_user.my_plans.recent.preload(plan: :area)
      render json: my_plans, each_serializer: MyPlansSerializer
    end

    # POST /v1/my_plans(.:format)
    def create
      my_plan = @current_user.my_plans.create!(plan_id: plan_params[:plan_id])
      render json: my_plan, status: :created
    end

    # GET /v1/my_plans/:id(.:format)
    def show
      my_plan = @current_user.my_plans.find(params[:id])
      render json: my_plan
    end

    # DELETE /v1/my_plans/:id(.:format)
    def destroy
      my_plan = @current_user.my_plans.find(params[:id])
      head :no_content if my_plan.destroy!
    end

    private

      def plan_params
        params.require(:plan).permit(:plan_id)
      end
  end
end
