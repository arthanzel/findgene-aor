class AuthController < ApplicationController
  before_filter :restrict_access, only: [:logout]

  def login
    if User.authenticate(params[:username], params[:password])
      render json: Access.create().token
    else
      head :unauthorized
    end
  end

  def logout
    Access.find_by_token(@token).destroy()

    head :no_content
  end
end
