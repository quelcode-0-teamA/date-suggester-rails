module V1
  class UsersController < ApplicationController
    before_action :authorize!, except: %i[create_temp_user login]
    before_action :set_user, only: %i[show]

    def create_temp_user
      temp_user = User.create!(sign_up_temp_user_params)
      render json: temp_user, serializer: MeSerializer, status: :created
    end

    def update_from_temp_to_formal
      @current_user.update!(sign_up_formal_user_params)
      render json: @current_user, serializer: MeSerializer
    end

    def login
      user = User.find_by(email: login_params[:email])
      if user&.authenticate(login_params[:password])
        render json: user, serializer: MeSerializer
      else
        render_error_message(
          'Unauthorized',
          'ログインに失敗しました',
          :unauthorized
        )
      end
    end

    def show
      render json: @user
    end

    private

      def set_user
        @user = User.find(params[:id])
      end

      def sign_up_temp_user_params
        params.require(:temp_user).permit(:birth_year, :area_id)
      end

      def sign_up_formal_user_params
        params.require(:formal_user).permit(
          :email, :password, :password_confirmation
        )
      end

      def login_params
        params.require(:user).permit(:email, :password)
      end

      def user_edit_params
        params.require(:user).permit(
          :name, :email, :birth_year,
          :gender, :area_id
        )
      end
  end
end
