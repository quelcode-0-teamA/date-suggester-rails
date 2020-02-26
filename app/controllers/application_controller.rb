class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  rescue_from StandardError, with: :render_500
  rescue_from AbstractController::ActionNotFound, with: :render_404
  rescue_from ActionView::MissingTemplate, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from ActionController::UnknownFormat, with: :render_404
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActiveRecord::RecordNotSaved, with: :render_404
  rescue_from ActiveRecord::RecordInvalid, with: :render_400
  rescue_from ActionController::ParameterMissing, with: :render_400
  rescue_from ActionController::InvalidCrossOriginRequest, with: :render_400
  rescue_from ActionController::InvalidAuthenticityToken, with: :render_422

  def render_error_message(message, errors, status)
    render json: {
      message: message,
      errors: errors
    }, status: status
  end

  def render_400(error)
    Rails.logger.info(error)
    render json: {
      message: 'Bad Request',
      errors: error.message
    }, status: :bad_request
  end

  def render_401
    render json: {
      message: 'Unauthorized'
    }, status: :unauthorized
  end

  def render_403
    render json: {
      message: 'Forbidden'
    }, status: :forbidden
  end

  def render_404(error)
    Rails.logger.info(error)
    render json: {
      message: 'Not Found',
      errors: error.message
    }, status: :not_found
  end

  def render_422(error)
    Rails.logger.info(error)
    render json: {
      message: 'Unprocessable Entity',
      errors: error.message
    }, status: :unprocessable_entity
  end

  def render_500(error)
    Rails.logger.error(error)
    ExceptionNotifier.notify_exception(
      error,
      env: request.env,
      data: { message: error.message }
    )
    render json: {
      message: 'Internal Server Error',
      errors: error.message
    }, status: :internal_server_error
  end

  private

    def authorize!
      return if current_user

      render_401
    end

    def current_user
      @current_user ||= User.find_by(token: bearer_token)
    end

    def bearer_token
      authenticate_with_http_token { |t| t }
    end
end
