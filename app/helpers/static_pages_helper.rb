module StaticPagesHelper
  
  # Logs in the given user.Actually this should be done in SessionHelper,
  # but in this situation the home page actually is the login page, too.
  # That's why the login helper put in here.
  def log_in(user)
    session[:user_id] = user.id
  end
  
  # Remembers a user on a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  # Return the current logged-in user (if any).
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: session[:user_id])
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
  # Return true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end
  
    # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
  # Logs out the current user.
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
  
end
