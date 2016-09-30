class UsersController < ApplicationController
  before_action :authenticate_user!
  # after_action :verify_authorized

  def index
    @users = User.all
    authorize User
  end

  def create
    @user = User.new(secure_params)
    @user.save
    redirect_to users_path, :notice => "User Created."

  end
  #
  # def show
  #   @user = User.find(params[:id])
  #   authorize @user
  # end
  #


  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def secure_params
    params.require(:user).permit(:role, :first_name, :last_name, :email, :password, children_attributes: [:first_name, :last_name, :birthdate])
  end

end
