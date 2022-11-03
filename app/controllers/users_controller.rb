class UsersController < ApplicationController
  def index 
   @user = User.paginate(page: params[:page], per_page: 6)
  end
  
  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 3)
  end

  def create
    @user = User.new(user_params)
    if @user.save
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
      redirect_to articles_path
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
