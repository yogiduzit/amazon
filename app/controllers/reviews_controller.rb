class ReviewsController < ApplicationController

  before_action :authenticate_user! 
  before_action :authorize!, only: [:update, :destroy]
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
    @review.destroy
    redirect_to product_path(@review.product)


    
  end

  def toggle
    review = Review.find(params["id"])
    review.hidden = !review.hidden
    review.save
    redirect_to product_path(review.product.id)
  end
  
  private
  def review_params
    params.require('review').permit(:body, :rating)
  end

  def authorize!
    @review = Review.find_by(id: params["id"])
    redirect_to product_path(@review.product), alert: 'Not Authorized' unless can?(:crud, @review)
    
  end

end
