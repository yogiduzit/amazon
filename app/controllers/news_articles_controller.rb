class NewsArticlesController < ApplicationController
  def new
    @news_article = NewsArticle.new
  end

  def create
    @news_article = NewsArticle.new news_article_params

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
    news_article = find_news_article_before_actions
    news_article.destroy
    flash[:notice] = "Deleted an article"
    redirect_to news_articles_path
  end

  def index
    @news_articles = NewsArticle.all.order("id ASC")
  end

  private
  def news_article_params
    params.require(:news_article).permit(:title, :description, :like_count)
  end

  def find_news_article_before_actions
    NewsArticle.find(params["id"])
  end
end
