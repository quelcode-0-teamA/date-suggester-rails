module V1
  module Mypage
    class UserController < ApplicationController
      before_action :authorize!

      def show
        render json: @current_user
      end

      def update
        @current_user.update!(user_edit_params)
        render json: @current_user
      end

      def destroy
        @current_user.destroy!
        render status: :no_content
      end

      private

        def user_edit_params
          params.require(:user).permit(
            :name, :email, :birth_year,
            :gender, :area_id
          )
        end
    end
  end
end
