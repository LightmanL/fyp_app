class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    #debugger
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the _____ site!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  private
    # so that no one can signup with administrative right!
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                    :password_confirmation)
    end
  
end
