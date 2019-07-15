class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end
  def show
    @tag = Tag.find(params["tag_id"])
    @products = @tag.products
  end
end
