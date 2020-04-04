module V1
  class UsersController < ApplicationController
    before_action :authorize!

    # GET /v1/users/:id(.:format)
    def show
      render json: User.find(params[:id])
    end

    # PUT /v1/users/:id(.:format)
    def update
      user = User.find(params[:id])
      if current_user?(user)
        if avatar_params[:avatar]
          user.avatar.attach(avatar_params[:avatar])
        end
        render json: user if user.update!(user_params)
      else
        render_403
      end
    end

    # DELETE /v1/users/:id(.:format)
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

      def avatar_params
        params.require(:user).permit(:avatar)
      end
  end
end
