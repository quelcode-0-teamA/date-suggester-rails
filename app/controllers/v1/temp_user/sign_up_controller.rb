module V1
  module TempUser
    class SignUpController < ApplicationController
      # POST /v1/temp_user/sign_up(.:format)
      def create
        temp_user = User.create!(temp_sign_up_params)
        render json: temp_user, serializer: MeSerializer, status: :created
      end

      private

        def temp_sign_up_params
          params.require(:temp_user).permit(:birth_year, :area_id)
        end
    end
  end
end
