class ApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Token

  # Null-session empties the session on a potentially forged request.
  # This app is 100% API, so null_session is perfect in combination with
  # access tokens.
  protect_from_forgery with: :null_session

  # Handle common exceptions
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # before_filter :auth_token

  private
    def record_not_found(error)
      head :not_found
    end

  protected
    def auth_token
      token = token_and_options(request)
      @token = if token then token[0] else nil end
    end

    def restrict_access
      authenticate_or_request_with_http_token do |token, options|
        @token = token
        Access.exists?(token: token)
      end
    end
end
