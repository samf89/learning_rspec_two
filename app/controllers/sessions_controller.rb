class SessionsController < ApplicationController 

  def create
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      log_in(@user)
      redirect_to user_path(@user)
    else
      @error_message = 'Incorrect Email/Password'
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

end
