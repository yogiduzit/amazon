class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email params[:email]

    if user && user.authenticate(params[:password])
      # bcrypt gem adds a method to authenticate which 
      # encrypts the password and compares it with the 
      # one stored in database.
      session[:user_id] = user.id
      # session contains the user_id option telling it 
      #if the user is logged in or not.
      redirect_to root_path, notice: 'Logged In'
    else
      flash.now[:alert] = "Email or Password is invalid"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged Out'
  end
end
