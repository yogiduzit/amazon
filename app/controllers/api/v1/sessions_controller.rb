class Api::V1::SessionsController < Api::ApplicationController
  before_action :authenticate_user!, only: [:destroy]

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      render(json: {user_id: user.id}, status: 200)
    else
      render(json: {status: 404}, status: 404)
    end
  end

  def destroy
    session[:user_id] = nil
    render(json: {status: 200}, status: 200)
  end
end
