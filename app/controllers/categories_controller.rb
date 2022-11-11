class CategoriesController < ApplicationController
  before_action :require_admin, only: [:new]
  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "category was succesfully created"
      redirect_to categories_path
    else
      render "new"
    end
  end
  def destroy 

  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
    def require_admin
    if  logged_in? && !current_user.admin?
      flash[:danger] = "only admin users can do that"
      redirect_to root_path
    end
  end
end
