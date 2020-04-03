class UsersController < ApplicationController
  def signup
    @user = User.new()
  end
  
  def create
    if user_already_exists?
      try_again
    else 
      @user = User.new(user_params)
      navigate_home_if_successful
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end

  def user_already_exists?
    User.find_by_email(user_params[:email]) ? true : false
  end

  def try_again
    flash[:success] = "Email already in use"
    redirect_to '/'
  end

  def navigate_home_if_successful
    if @user.save
      flash[:success] = "Sign Up Successful!"
      redirect_to '/home/index'
    else
      flash[:success] = "Sign up failed to save"
      render 'signup'
    end
  end

end
