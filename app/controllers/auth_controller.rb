class AuthController < ApplicationController
  def index
    begin
      username, password = request.headers["X-FindGene-Auth"].split("/", 2)
      raise "Username or password are blank" unless username and password

      @user = User.authenticate(username, password)
      raise "Can't find user" unless @user

      head :ok
    rescue
      head 404
    end
  end
end
