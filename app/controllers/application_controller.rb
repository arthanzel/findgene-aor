class ApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Token

  # Null-session empties the session on a potentially forged request.
  # This app is 100% API, so null_session is perfect in combination with
  # access tokens.
  protect_from_forgery with: :null_session

  # Handle common exceptions
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private
    def record_not_found(error)
      head :not_found
    end

  protected
    def restrict_access
      begin
        username, password = request.headers["X-FindGene-Auth"].split("/", 2)
        raise "Username or password are blank" unless username and password

        @user = User.authenticate(username, password)
        raise "Can't find user" unless @user
      rescue
        head :unauthorized
      end
    end
end
