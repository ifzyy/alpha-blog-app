class PagesController < ApplicationController
    def home
        @pages = Article.paginate(page: params[:page], per_page: 5)
    end
end