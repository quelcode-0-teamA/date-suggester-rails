module V1
  module FormalUser
    class SignUpController < ApplicationController
      before_action :authorize!

      def create
        @current_user.update!(formal_sign_up_params)
        render json: @current_user, serializer: MeSerializer
      end

      private

        def formal_sign_up_params
          params.require(:formal_user).permit(
            :email, :password, :password_confirmation
          )
        end
    end
  end
end
