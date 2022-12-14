class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show, :destroy]
    before_action :require_same_user, only: [:edit,:update,:destroy]
    before_action :require_admin, only: [:destroy]
  def index 
   @user = User.paginate(page: params[:page], per_page: 6)
  end
  
  def new
    @user = User.new
  end

  def edit
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 3)
  end

  def destroy
     @user = User.find(params[:id])
     @user.destroy
     flash[:danger] = "#{@user} has been succesfully deleted" 
     redirect_to users_path
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to alpha blog"
      redirect_to user_path(@user)
    else
      render "new"
    end
  end

  def update
    @user = User.new(user_params)
    if @user.update user_params
      flash[:success] = "Your account was succesfully updated"
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
  def require_same_user
    if  current_user != @user && !current_user.admin?
      flash[:danger] = "You can only edit your own account"
      redirect_to root_path
    end
  end

  def require_admin
    if  logged_in? && !current_user.admin?
      flash[:danger] = "only admin users can do that"
      redirect_to root_path
    end
  end
end
