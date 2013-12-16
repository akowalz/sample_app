module SessionsHelper

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    # equivalent to:
    # cookies[:remember_token] = { value:   remember_token,
    #                        expires: 20.years.from_now.utc }
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user   
  end

  def current_user
    # So here's the magic!  current user is a METHOD that will return the user
    # It just grabs the remember token from the cookie
    # encrypts it
    # and finds the appropriate user from the database
    # Now, we can use current_user as if it were just a user like:
    # current_user.name 
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def signed_in?
    !current_user.nil? 
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
end
