module V1
  class UsersController < ApplicationController
    before_action :authorize!, except: %i[create_temp_user login]
    before_action :set_user, only: %i[update destroy show]
    before_action :current_user?, only: %i[update destroy]

    def create_temp_user
      temp_user = User.create!(sign_up_temp_user_params)
      render_serializer(temp_user, MeSerializer)
    end

    def update_from_temp_to_formal
      @current_user.update!(sign_up_formal_user_params)
      render_serializer(@current_user, MeSerializer)
    end

    def login
      user = User.find_by(email: login_params[:email])
      if user&.authenticate(login_params[:password])
        render_serializer(user, MeSerializer)
      else
        error_message(:unauthorized, 'ログインに失敗しました')
      end
    end

    def show
      render_serializer(@user, UserSerializer)
    end

    def update
      @user.update!(user_edit_params)
      render_serializer(@user, UserSerializer)
    end

    def destroy
      @user.destroy!
      render json: { 'message': '正常にUser削除されました' }
    end

    private

      def set_user
        @user = User.find_by!(id: params[:id])
      end

      def current_user?
        error_message(:unauthorized, '権限がありません') unless @user.id == @current_user.id
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
