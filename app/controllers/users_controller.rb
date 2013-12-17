class UsersController < ApplicationController
  # will cause the singed in user method to be called before the specified methods
  # used for authorization
  before_action :signed_in_user, only: [:edit, :update, :index]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user ,    only: :destroy

  def index
    @users = User.paginate(page: params[:page] )
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit 
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  private

    # Security with strong parameters.  Basically just gets the contents of the params hash
    # but only permits certain parameters so that you can't say and ?admin=1 
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Before filters
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in." 
     end
   end
      # equivalent to 
      # unless signed_in?
      #   flash[:notice] = "Please sign in."
      #   redirect_to signin_url
      # end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end

# Reminder: This is the UserController talking to the model
# User.new and User.find are methods of the ActiveRecord object, so that's how they 
# communicate.  You do NOT call a User.method in a view, it goes through the model 