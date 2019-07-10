class NewsArticlesController < ApplicationController
  def new
    @news_article = NewsArticle.new
  end
end
