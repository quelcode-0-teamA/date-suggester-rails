class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  def authorize!
    return if current_user

    render json: { 'message': 'ログインしていません' }, status: :unauthorized
  end

  def current_user
    @current_user ||= User.find_by(token: bearer_token)
  end

  def render_serializer(data, set_serializer)
    render json: data, serializer: set_serializer
  end

  def render_collection_serializer(datas, set_serializer)
    render json: ActiveModel::Serializer::CollectionSerializer.new(
      datas, serializer: set_serializer
    )
  end

  def error_message(status, message)
    render json: { 'message': message }, status: status
  end

  private

    def bearer_token
      authenticate_with_http_token { |t| t }
    end
end
