class SessionsController < ApplicationController 

  def create
    user = User.find(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      redirect_to user_path(user)
    else
      render :new
    end
  end

end
