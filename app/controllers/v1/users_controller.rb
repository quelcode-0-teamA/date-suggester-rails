module V1
  class UsersController < ApplicationController
    before_action :authorize!

    def show
      render json: User.find(params[:id])
    end

    def update
      user = User.find(params[:id])
      if current_user?(user)
        render json: user if user.update!(user_params)
      else
        render_403
      end
    end

    def destroy
      user = User.find(params[:id])
      if current_user?(user)
        render status: :no_content if user.destroy!
      else
        render_403
      end
    end

    private

      def current_user?(user)
        @current_user == user
      end

      def user_params
        params.require(:user).permit(
          :name, :email, :birth_year,
          :gender, :area_id
        )
      end
  end
end
