class StaticPagesController < ApplicationController
  def home
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
  
  def create
    user = User.find_by(email: params[:static_pages][:email].downcase)
    if user && user.authenticate(params[:static_pages][:password])
      if user.activated?
        log_in user
        params[:static_pages][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'home'
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end  
end
