class NewsArticlesController < ApplicationController

  before_action :authenticate_user!, except: [:show, :index]
  before_action :authorize!, only: [:edit, :update, :destroy]

  def new
    @news_article = NewsArticle.new
  end

  def create
    @news_article = NewsArticle.new news_article_params
    @news_article.user = current_user
    if @news_article.valid?
      @news_article.save
      redirect_to news_articles_path(@news_article)
    else
      render :new
    end

  end

  def show
    @news_article = find_news_article_before_actions
  end

  def destroy
    @news_article = find_news_article_before_actions
    @news_article.destroy
    flash[:notice] = "Deleted an article"
    redirect_to news_articles_path
  end

  def index
    @news_articles = NewsArticle.all.order("id ASC")
  end

  def edit
    @news_article = find_news_article_before_actions
  end

  def update
    @news_article = NewsArticle.find(params["id"])
    redirect_to news_article_path
  end

  private
  def news_article_params
    params.require(:news_article).permit(:title, :description, :like_count)
  end

  def find_news_article_before_actions
    NewsArticle.find(params["id"])
  end

  def authorize!
    redirect_to root_path, alert: "Access Denied" unless can?(:crud, @news_article)
  end
end
