class UsersController < ApplicationController
  before_action :set_user, only: %i(show edit update destroy)

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user)
            .permit(:username, 
                    :firstname,
                    :lastname,
                    :email,
                    :password,
                    :password_confirmation)
    end
end
