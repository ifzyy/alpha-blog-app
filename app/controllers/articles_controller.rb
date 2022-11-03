class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit,:update, :show, :destroy]
  def index
    @article = Article.all
  end

    def show

  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      #do soemthinge
      flash[:success] = "Article was succesfully created"
      redirect_to article_path(@article)
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @article.update article_params
      flash[:success] = "Article was succesfully updated"
      redirect_to article_path(@article)
    else
      render "edit"
    end
  end

  def destroy
    @article.destroy
    flash[:danger] = "Article was succesfully deleted"
    redirect_to articles_path, status: :see_other
  end

  private
def set_article
@article = Article.find(params[:id])
end
  def article_params
    params.require(:article).permit(:title, :description)
  end
end
