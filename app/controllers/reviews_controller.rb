class ReviewsController < ApplicationController

  before_action :authenticate_user! 
  def create

    @review = Review.new review_params
    @product = Product.find(params["product_id"])

    @review.product = @product
    @review.user = current_user
    

    if @review.save
      redirect_to product_path(@product)
    else
      render 'products/show'
    end
  end

  def destroy

    @review = Review.find(params["id"])

    if can?(:crud, @review)
      @review.destroy
      redirect_to product_path(@review.product)
    else
      head :unauthorized
    end

    
  end

  def hide
    review = Review.find(params["id"])
    review.hidden = true
    review.save
    redirect_to product_path(review.product.id)
  end

  private

  def review_params
    params.require('review').permit(:body, :rating)
  end

end
