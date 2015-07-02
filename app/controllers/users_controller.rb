class UsersController < ApplicationController
  before_action :set_user, only: %i(show edit update destroy)
  before_action :has_admin_access, only: %i(new create)

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
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
