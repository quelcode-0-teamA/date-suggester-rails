module V1
  class SignInController < ApplicationController
    # POST /v1/sign_in(.:format)
    def create
      user = User.find_by(email: sign_in_params[:email])
      if user&.authenticate(sign_in_params[:password])
        render json: user, serializer: MeSerializer
      else
        render_401
      end
    end

    private

      def sign_in_params
        params.require(:user).permit(:email, :password)
      end
  end
end
